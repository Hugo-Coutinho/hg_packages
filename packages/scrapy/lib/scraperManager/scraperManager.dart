import 'package:scrapy/core/exception/scrapy_exception.dart';
import 'package:scrapy/model/scrapping_model.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

abstract class ScraperManager {
  Future<Either<ScraperException, List<String>>> scrapping(ScrappingModel model);
}

class ScraperManagerImpl extends ScraperManager {
  final Logger _logger;
  final WebScraper _webScraper;
  ScraperManagerImpl(this._logger, this._webScraper);

  @override
  Future<Either<ScraperException, List<String>>> scrapping(ScrappingModel model) async {
    _webScraper.baseUrl = model.domain;
    if (await _webScraper.loadWebPage(model.path)) {
      List<String> elements = _webScraper.getElementTitle(model.address);
      if (elements.isEmpty) { _logger.e('web scrapy it was empty'); return Left(ScraperException()); }
      _logger.i('web extract successfully worked\n $elements');
      return Right(elements);
    }
    _logger.wtf('error from loading web page');
    return Left(ScraperException());
  }
}