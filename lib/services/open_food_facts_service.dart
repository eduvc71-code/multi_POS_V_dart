import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OpenFoodFactsService {
  /// Lista de subdominios/endpoints a consultar en orden de prioridad para escaneo:
  static const List<String> _latamDomains = [
    'https://bo.openfoodfacts.org', // Bolivia (Prioridad Principal)
    'https://world.openfoodfacts.org', // Global / América Latina
    'https://ar.openfoodfacts.org', // Argentina
    'https://mx.openfoodfacts.org', // México
    'https://co.openfoodfacts.org', // Colombia
    'https://pe.openfoodfacts.org', // Perú
    'https://cl.openfoodfacts.org', // Chile
    'https://br.openfoodfacts.org', // Brasil
    'https://ec.openfoodfacts.org', // Ecuador
    'https://py.openfoodfacts.org', // Paraguay
    'https://uy.openfoodfacts.org', // Uruguay
    'https://ve.openfoodfacts.org', // Venezuela
    'https://gt.openfoodfacts.org', // Guatemala
    'https://cr.openfoodfacts.org', // Costa Rica
    'https://sv.openfoodfacts.org', // El Salvador
    'https://hn.openfoodfacts.org', // Honduras
    'https://ni.openfoodfacts.org', // Nicaragua
    'https://pa.openfoodfacts.org', // Panamá
    'https://do.openfoodfacts.org', // República Dominicana
  ];

  /// Busca un producto por código de barras primero en Bolivia y luego en América Latina.
  static Future<Map<String, dynamic>?> searchProductByBarcode(
    String barcode,
  ) async {
    for (final domain in _latamDomains) {
      final urlString = '$domain/api/v0/product/$barcode.json';
      final result = await _fetchFromUrl(urlString);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  static Future<Map<String, dynamic>?> _fetchFromUrl(String urlString) async {
    try {
      final url = Uri.parse(urlString);
      final response = await http
          .get(url)
          .timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 1 && data['product'] != null) {
          final product = data['product'];

          final name = product['product_name_es'] ??
              product['product_name'] ??
              product['generic_name_es'] ??
              product['generic_name'];

          if (name != null && name.toString().trim().isNotEmpty) {
            String origin = 'Open Food Facts';
            if (urlString.contains('bo.openfoodfacts.org')) {
              origin = 'Open Food Facts (Bolivia)';
            } else if (urlString.contains('world.openfoodfacts.org')) {
              origin = 'Open Food Facts (Global / América Latina)';
            } else {
              origin = 'Open Food Facts (Latinoamérica)';
            }

            return {
              'nombre': name.toString().trim(),
              'marca': product['brands'] ?? '',
              'categoria': product['categories'] ?? '',
              'origen': origin,
            };
          }
        }
      }
    } catch (e) {
      debugPrint('Error al consultar $urlString: $e');
    }
    return null;
  }

  /// Obtiene la totalidad de productos registrados para Bolivia desde Open Food Facts
  /// mediante solicitudes paginadas masivas.
  static Future<List<Map<String, dynamic>>> fetchBoliviaProducts() async {
    final Map<String, Map<String, dynamic>> itemsMap = {};
    int page = 1;
    const int pageSize = 250;
    bool hasMore = true;

    while (hasMore && page <= 10) { // Hasta 2,500+ productos
      final url = Uri.parse(
        'https://world.openfoodfacts.org/api/v2/search?countries_tags_en=bolivia&fields=code,product_name,product_name_es,brands,categories&page_size=$pageSize&page=$page',
      );

      try {
        final response = await http.get(url).timeout(const Duration(seconds: 10));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final List? products = data['products'];

          if (products != null && products.isNotEmpty) {
            for (var item in products) {
              final code = item['code']?.toString().trim();
              final name = item['product_name_es'] ??
                  item['product_name'] ??
                  item['generic_name'];

              if (code != null &&
                  code.isNotEmpty &&
                  name != null &&
                  name.toString().trim().isNotEmpty) {
                itemsMap[code] = {
                  'codigo': code,
                  'nombre': name.toString().trim(),
                  'marca': item['brands'] ?? '',
                  'categoria': item['categories'] ?? 'General',
                };
              }
            }

            if (products.length < pageSize) {
              hasMore = false;
            } else {
              page++;
            }
          } else {
            hasMore = false;
          }
        } else {
          hasMore = false;
        }
      } catch (e) {
        debugPrint('Error en la página $page de Open Food Facts Bolivia: $e');
        hasMore = false;
      }
    }

    // Fallback: Si no devolvió suficientes o falla la API v2, probar el JSON del país
    if (itemsMap.length < 20) {
      try {
        final fallbackUrl = Uri.parse(
          'https://bo.openfoodfacts.org/country/bolivia.json',
        );
        final response = await http.get(fallbackUrl).timeout(const Duration(seconds: 8));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['products'] != null && data['products'] is List) {
            for (var item in data['products']) {
              final code = item['code']?.toString().trim();
              final name = item['product_name_es'] ?? item['product_name'];
              if (code != null &&
                  code.isNotEmpty &&
                  name != null &&
                  name.toString().trim().isNotEmpty) {
                itemsMap[code] = {
                  'codigo': code,
                  'nombre': name.toString().trim(),
                  'marca': item['brands'] ?? '',
                  'categoria': item['categories'] ?? 'General',
                };
              }
            }
          }
        }
      } catch (e) {
        debugPrint('Error en el fallback de Open Food Facts Bolivia: $e');
      }
    }

    return itemsMap.values.toList();
  }

  /// Descarga el catálogo masivo en línea según el sector o rubro del negocio.
  static Future<List<Map<String, dynamic>>> fetchProductsBySector(
    String businessType,
  ) async {
    if (businessType == 'Tienda') {
      return await fetchBoliviaProducts();
    }

    String categoryQuery = 'tools';
    String apiDomain = 'openproductsfacts.org';

    if (businessType == 'Farmacia') {
      categoryQuery = 'health-and-beauty,cosmetics,pharmacy';
      apiDomain = 'openbeautyfacts.org';
    } else if (businessType == 'Ferretería') {
      categoryQuery = 'hardware,tools,building-supplies';
      apiDomain = 'openproductsfacts.org';
    } else if (businessType == 'Autopartes' || businessType == 'Motopartes') {
      categoryQuery = 'auto-parts,motorcycle-parts,vehicles';
      apiDomain = 'openproductsfacts.org';
    }

    final Map<String, Map<String, dynamic>> itemsMap = {};
    final url = Uri.parse(
      'https://world.$apiDomain/api/v2/search?categories_tags_en=$categoryQuery&fields=code,product_name,product_name_es,brands,categories&page_size=250',
    );

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List? products = data['products'];
        if (products != null && products.isNotEmpty) {
          for (var item in products) {
            final code = item['code']?.toString().trim();
            final name = item['product_name_es'] ??
                item['product_name'] ??
                item['generic_name'];

            if (code != null &&
                code.isNotEmpty &&
                name != null &&
                name.toString().trim().isNotEmpty) {
              itemsMap[code] = {
                'codigo': code,
                'nombre': name.toString().trim(),
                'marca': item['brands'] ?? '',
                'categoria': businessType,
              };
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Error obteniendo catálogo para rubro $businessType: $e');
    }

    return itemsMap.values.toList();
  }
}
