import scrapy

from scraper_auchan.items import ScraperAuchanItem

class AuchanSpider(scrapy.Spider):
    name = 'auchan'
    allowed_domains = ['www.auchandirect.fr']
    start_urls = [
            'http://www.auchandirect.fr/boissons/eaux/eau-de-source/id1/478/' +
            '4607'
            ]

    def parse(self, response):
        for sel in response.xpath('//div[@class="fiche-produit"]'):
            item = ScraperAuchanItem()
            item['id'] = response.url.split('/')[-1]
            item['name'] = sel \
                    .xpath('//span[@class="titre-principal"]/text()') \
                    .extract()
            item['desc'] = sel.xpath('//span[@class="titre-annexe"]/text()') \
                    .extract()
            item['price'] = sel \
                    .xpath('//div[@class="prix-actuel"]/span/text()') \
                    .extract()
            item['pricePerUnit'] = sel \
                    .xpath('//div[@class="prix-annexe"]/p/text()') \
                    .extract()
            item['composition'] = sel \
                    .xpath('//span[@class="texte-info-normal"]/text()') \
                    .extract()
            yield item
