# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
from scrapy.exceptions import DropItem

#여백을 없애주는 파이프라인 생성
class CleanCategoryPipeline :
    def process_item(self, item, spider):
        item["category"] = item["category"].strip()
        return item
#중복되는 데이터 제거하는 파이프라인(Set : iterable한 데이터를 만들되 중복되지 않도록 해주는 prototype객체)
class SetPipeline :
    def __init__(self):#items 에서 __init__이라는 생성자 함수를 사용해서 불러옴
        self.categories_seen = set()#프로젝트로 생성된 item에 이미 카테고리가 들어왔다면 중복값을 받지 못하게 set함수를 적용

    def process_item(self, item, spider) :
        if item["category"] in self.categories_seen :
            raise DropItem("Duplicate item found : %s" % item)#카테고리가 이미 있는 값이라면 없애주고
        else :
            self.categories_seen.add(item["category"])#카테고리가 처음보는 값이라면 넣어줘라
            return item
#중복되는 문구 지워주는 파이프라인
class RemovePhrasePipeline :
    def process_item(self, item, spider):
        item["category"] = item["category"].replace(" 관련 상품 추천", "")
        return item