# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
from scrapy.exceptions import DropItem

class MikefunProject2Pipeline:
    def process_item(self, item, spider):
        if item["description"] :
            item["description"] = item["description"].strip()
            return item
        else :
            raise DropItem("Missing description in %s" % item)


#MikefunProject2Pipeline 클래스를 만들건데 이 클래스는 process_item라는 함수를 만들어 세개의 인자값을 받는다
#item의 description 이 있다면 .strip()으로 반영해서 item에 넣어라
#근데 만약 깜빡하고 description이 없다면 DropItem이라는 함수로 찾아온 값을 지우고 잊어버린 것을 %s를 통해 잊어버린item을 출력해라