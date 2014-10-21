import scrapy
from scrapy.contrib.spiders import CrawlSpider, Rule
from scrapy.contrib.linkextractors import LinkExtractor

from scraper_auchan.items import ScraperAuchanItem

class AuchanSpider(CrawlSpider):
    name = 'auchan'
    allowed_domains = ['www.auchandirect.fr']
    start_urls = ['http://www.auchandirect.fr/marche/legumes/id3/404/463']

    followRegex = 'http://www.auchandirect.fr/[a-z]+/[a-z]+/[a-z-,]+/id0/[0-9]+'
    parseRegex = 'http://www.auchandirect.fr/[a-z]+/[a-z]+/[a-z-]+/id1/' + \
        '[0-9]+/[0-9]+'
    rules = (
            Rule(LinkExtractor(allow=(followRegex, ))),
            Rule(LinkExtractor(allow=(parseRegex, )), callback='parse_product'),
            )

    def parse_product(self, response):
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
