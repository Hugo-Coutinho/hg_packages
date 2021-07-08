import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:scrapy/core/exception/scrapy_exception.dart';
import 'package:scrapy/scraperManager/scraperManager.dart';
import 'mock/mocking_dependencies.dart';

@TestOn('vm')

main() {

  ScraperManager _manager;
  MockWebScraper _scraper;
  Logger _logger;

  final String _baseUrl = 'mockBaseUrl';
  final String _domain = 'mockDomain';
  final String _address = 'mockAddress';

  setUp(() {
    _logger = Logger();
    _scraper = MockWebScraper();
    _manager = ScraperManagerImpl(_logger, _scraper);
  });

  test('Should get success', () async {
    // arrange
    final List<String> mockResponse = ['flamengo', 'campeao'];
    when(_scraper.loadWebPage(_baseUrl)).thenAnswer((_) async => Future.value(true));
    when(_scraper.getElementTitle(_address)).thenReturn(mockResponse);

    // act
    final elements = await _manager.scrapping(_baseUrl, _domain, _address);
    expect(elements.first, mockResponse.first);
  });

  test('Empty extraction should throw exception', () async {
    // arrange
    final List<String> mockResponse = [];
    when(_scraper.loadWebPage(_baseUrl)).thenAnswer((_) async => Future.value(true));
    when(_scraper.getElementTitle(_address)).thenReturn(mockResponse);
    // act
    try {
      await _manager.scrapping(_baseUrl, _domain, _address);
      // assert
      fail('should throw exception');
    } on ScraperException {
      print("fail as expected");
    }
  });

  test('load web page failed should throw exception', () async {
    // arrange
    final List<String> mockResponse = [];
    when(_scraper.loadWebPage("")).thenAnswer((_) async => Future.value(false));
    when(_scraper.getElementTitle(_address)).thenReturn(mockResponse);
    // act
    try {
    await _manager.scrapping('mockBaseUrl', 'mockDomain', 'mockAddress' );
    fail('should throw exception');
  } on ScraperException {
    print("fail as expected");
  }
  });
}