import scrapy
from mikefun_project2.items import MikefunProject2Item

class MikefunSpider(scrapy.Spider):
    name = "mikefun"
    allowed_domains = ["davelee-fun.github.io"]
    start_urls = ["https://davelee-fun.github.io"]

    def parse(self, response):
        item = MikefunProject2Item()
        item["title"] = response.css("h1.sitetitle::text").get()
        description = response.xpath("//p[@class='lead']/text()").get()
        item["description"] = description

        yield item