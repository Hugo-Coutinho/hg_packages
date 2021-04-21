import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:scrapy/core/exception/scrapy_exception.dart';
import 'package:scrapy/model/scrapping_model.dart';
import 'package:scrapy/scraperManager/scraperManager.dart';
import 'mock/mocking_dependencies.dart';

@TestOn('vm')

main() {

  ScraperManager _manager;
  MockWebScraper _scraper;
  Logger _logger;

  setUp(() {
    _logger = Logger();
    _scraper = MockWebScraper();
    _manager = ScraperManagerImpl(_logger, _scraper);
  });

  test('Should get success', () async {
    // arrange
    final List<String> mockResponse = ['flamengo', 'campeao'];
    final model = ScrappingModel('mockBaseUrl', 'mockDomain', 'mockAddress');
    when(_scraper.loadWebPage(model.path)).thenAnswer((_) async => Future.value(true));
    when(_scraper.getElementTitle(model.address)).thenReturn(mockResponse);

    // act
    final elements = await _manager.scrapping(model);
    elements.fold((l) {
      fail('should success');
    }, (r) {
      // assert
      expect(r.first, mockResponse.first);
    });
  });

  test('Empty extraction should throw exception', () async {
    // arrange
    final List<String> mockResponse = [];
    final model = ScrappingModel('mockBaseUrl', 'mockDomain', 'mockAddress');
    when(_scraper.loadWebPage(model.path)).thenAnswer((_) async => Future.value(true));
    when(_scraper.getElementTitle(model.address)).thenReturn(mockResponse);

    // act
    final elements = await _manager.scrapping(model);
    elements.fold((l) {
      final expected = l is ScraperException;
      if (!expected) fail('should throw scraper exception');
    }, (r) {
      // assert
      fail('should fail');
    });
  });

  test('load web page failed should throw exception', () async {
    // arrange
    final model = ScrappingModel('mockBaseUrl', 'mockDomain', 'mockAddress');
    when(_scraper.loadWebPage(model.path)).thenAnswer((_) async => Future.value(false));
    // act
    final elements = await _manager.scrapping(model);
    elements.fold((l) {
      final expected = l is ScraperException;
      if (!expected) fail('should throw scraper exception');
    }, (r) {
      // assert
      fail('should fail');
    });
  });
}