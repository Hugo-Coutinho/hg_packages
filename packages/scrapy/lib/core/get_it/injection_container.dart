import 'package:core/get_it/injection_container.dart';
import 'package:scrapy/scraperManager/scraperManager.dart';
import 'package:web_scraper/web_scraper.dart';

setupScrapyLocator() async {
  coreLocator.registerFactory(() => WebScraper());
  coreLocator.registerFactory<ScraperManager>(() => ScraperManagerImpl(coreLocator(), coreLocator()));
}