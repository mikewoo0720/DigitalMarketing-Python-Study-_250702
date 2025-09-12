

db.movies.aggregate([
{
    $facet: {
        latest5: [
        {$sort: {year: -1}},
        {$limit: 5},
        {$project: {_id: 0, title: 1, year: 1}}
        ],
        highRatedCount: [
        {$match: {"imdb.rating": {$gte: 8}}},
        {$count: "count"}
        ],
        genresByCount: [
            {$unwind: "$genres"},
            {$group: {_id: "$genres", count: {$sum: 1}}},
            {$sort: {count: -1}}
        ]
    }
},
{
    $project: {
        latest5: 1,
        highRatedCount: {$ifNull: [{$arrayElemAt: ["$highRatedCount.count", 0]}, 0]},
        genresByCount: 1
    }
}
])