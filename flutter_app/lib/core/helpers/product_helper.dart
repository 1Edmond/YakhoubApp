import 'package:multishop_tchad/features/vendor/product_details/enums/preview_type.dart';
import 'dart:math' as math;
import 'package:multishop_tchad/features/customer/product_details/domain/models/product_details_model.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

class ProductHelper{

  static ({double? end, double? start}) getProductPriceRange(ProductDetailsModel? productDetailsModel){
    double? startingPrice = 0;
    double? endingPrice;
    if(productDetailsModel?.variation?.isNotEmpty ?? false) {
      List<double?> priceList = [];
      for (var variation in productDetailsModel!.variation!) {
        priceList.add(variation.price);
      }
      priceList.sort((a, b) => a!.compareTo(b!));
      startingPrice = priceList[0];
      if(priceList[0]! < priceList[priceList.length-1]!) {
        endingPrice = priceList[priceList.length-1];
      }
    }else {
      startingPrice = productDetailsModel?.unitPrice;
    }

    return (start: startingPrice, end: endingPrice);
  }

  static String removeIframe(String htmlString) {
    final regex =  RegExp(
      r'(</span></p>)?(</p>)?<iframe[^>]*src="https:\/\/www\.youtube\.com\/embed\/[^"]*"[^>]*><\/iframe><p[^>]*>(<strong[^>]*>\s*<\/strong>)?<span[^>]*>',
      caseSensitive: false,
      dotAll: true,
    );

    return htmlString.replaceAll(regex, '')
        .replaceAll('&nbsp;', '');
  }

  static String htmlToPlainText(String htmlContent) {
    // Parse HTML string
    Document document = parse(htmlContent);

    StringBuffer buffer = StringBuffer();
    int olIndex = 1; // for ordered lists

    void parseNode(Node node) {
      if (node is Element) {
        switch (node.localName) {
          case 'h1':
          case 'h2':
          case 'h3':
          case 'h4':
          case 'h5':
          case 'h6':
            buffer.writeln('\n${node.text.trim()}\n');
            break;
          case 'p':
            buffer.writeln('${node.text.trim()}\n');
            break;
          case 'li':
          // detect if parent is <ol>
            if (node.parent?.localName == 'ol') {
              buffer.writeln('$olIndex. ${node.text.trim()}');
              olIndex++;
            } else {
              buffer.writeln('• ${node.text.trim()}');
            }
            break;
          case 'ol':
            olIndex = 1; // reset counter
            node.nodes.forEach(parseNode);
            buffer.writeln();
            break;
          case 'ul':
            node.nodes.forEach(parseNode);
            buffer.writeln();
            break;
          case 'br':
            buffer.writeln();
            break;
          default:
            node.nodes.forEach(parseNode);
        }
      } else if (node is Text) {
        final text = node.text.trim();
        if (text.isNotEmpty) buffer.write('$text ');
      }
    }

    // Parse body
    document.body?.nodes.forEach(parseNode);

    // Clean up multiple blank lines
    String plainText = buffer.toString()
        .replaceAll(RegExp(r'\n\s*\n\s*\n+'), '\n\n')
        .trim();

    return plainText;
  }
  static String removeSpacesAndLowercase(String input) {
    return input.replaceAll(' ', '').toLowerCase();
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
  static String replaceUnderscoreWithHyphen(String input) {
    return input.replaceAll('_', '-');
  }

  static List<String> processList(List<String> inputList) {
    return inputList.map((str) => str.toLowerCase().trim()).toList();
  }

  static String generateSKU() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = math.Random();
    String sku = '';

    for (int i = 0; i < 6; i++) {
      sku += chars[random.nextInt(chars.length)];
    }
    return sku;
  }
  static ({double? end, double? start}) getVendorProductPriceRange(dynamic product) {
    double? startingPrice = 0;
    double? endingPrice;
    if (product != null && product.variation != null && product.variation.isNotEmpty) {
      List<double?> priceList = [];
      for (var variation in product.variation) {
        priceList.add(variation.price);
      }
      priceList.sort((a, b) => a!.compareTo(b!));
      startingPrice = priceList[0];
      if (priceList[0]! < priceList[priceList.length - 1]!) {
        endingPrice = priceList[priceList.length - 1];
      }
    } else {
      startingPrice = product?.unitPrice;
    }
    return (start: startingPrice, end: endingPrice);
  }

  static PreviewType getFileType(String url) {
    if(url.contains('.pdf')) {
      return PreviewType.pdf;
    } else if(url.contains('.jpg') || url.contains('.jpeg') || url.contains('.png')) {
      return  PreviewType.image;
    } else if(url.contains('.mp4') || url.contains('.mkv') || url.contains('.avi') || url.contains('.flv') || url.contains('.mov') || url.contains('.wmv') || url.contains('.webm')) {
      return  PreviewType.video;
    } else if(url.contains('.mp3') || url.contains('.wav') || url.contains('.ogg') || url.contains('.m4a') || url.contains('.aac')) {
      return  PreviewType.audio;
    } else {
      return  PreviewType.others;
    }
  }
}
