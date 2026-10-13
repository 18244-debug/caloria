import 'dart:io';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final File imageFile;

  const ResultScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF1B3B36);
    const Color accentOrange = Color(0xFFE67E22);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F6),
      appBar: AppBar(
        title: const Text(
          'Resultado da Análise',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: primaryGreen,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagem do prato analisado em miniatura arredondada
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                imageFile,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Cartão principal com o Prato Identificado e a Nota A-E
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Prato Identificado:',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Bacalhau à Brás',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Nota A-E
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: accentOrange,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'C',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Cartão de Nutrientes
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informação Nutricional (Estimada)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),
                  Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _NutrientInfo(title: 'Calorias', value: '550 kcal'),
                      _NutrientInfo(title: 'Proteína', value: '32g'),
                      _NutrientInfo(title: 'Gordura', value: '24g'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Cartão da Dica Personalizada
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryGreen.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryGreen.withOpacity(0.2)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb, color: accentOrange, size: 30),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dica da CalorIA:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryGreen,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Boa quantidade de proteína, mas atenção às calorias se o teu objetivo for o défice. Tenta acompanhar com uma salada verde!',
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NutrientInfo extends StatelessWidget {
  final String title;
  final String value;

  const _NutrientInfo({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1B3B36))),
      ],
    );
  }
}