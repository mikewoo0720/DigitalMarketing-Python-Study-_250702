import scrapy
from mikefun_project4.items import MikefunProject4Item


class MultipleWebsSpider(scrapy.Spider):
    name = "multiple_webs"
    allowed_domains = ["davelee-fun.github.io"]
    start_urls = ["https://davelee-fun.github.io"]

    def start_requests(self):#스크래피 내장함수(framework) -> 여러페이지 가져오기 위한 함수
        urls = ["https://davelee-fun.github.io"]
        #list comprehension 구문
        urls.extend([f"https://davelee-fun.github.io/page{i}/" for i in range(2, 7)])

        for url in urls :
            yield scrapy.Request(url, self.parse)#yield 다음 약속된 코드에 가서 동작하라 parse

    def parse(self, response):
        titles = response.css("h4.card-text::text").getall()

        for title in titles :
            item = MikefunProject4Item()
            item["title"] = title
            yield item
