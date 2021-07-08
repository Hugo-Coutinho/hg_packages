import 'package:scrapy/core/exception/scrapy_exception.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:logger/logger.dart';

abstract class ScraperManager {
  Future<List<String>> scrapping(String domain, String path, String address);
}

class ScraperManagerImpl extends ScraperManager {
  final Logger _logger;
  final WebScraper _webScraper;
  ScraperManagerImpl(this._logger, this._webScraper);

  @override
  Future<List<String>> scrapping(String domain, String path, String address) async {
    _webScraper.baseUrl = domain;
    try {
      if (await _isWebPageLoaded(path)) {
        List<String> elements = _webScraper.getElementTitle(address);
        if (elements.isEmpty) { _logger.e('web scrapy it was empty'); throw ScraperException(); }
        _logger.i('web extract successfully worked\n $elements');
        return elements;
      } else {
        throw ScraperException();
      }
    } catch(e) {
      _logger.wtf('error from loading web page');
      throw ScraperException();
    }
  }

  Future<bool> _isWebPageLoaded(String path) async {
    var isPageLoaded = true;
    try {
      await _webScraper.loadWebPage(path);
      return isPageLoaded;
    } catch(e) {
    _logger.wtf('Scrapping loading page throw exception: $e');
    isPageLoaded = false;
    throw ScraperException();
    }
  }
}