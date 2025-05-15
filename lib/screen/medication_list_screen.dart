import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:application_medicines/auth_controller.dart';
import 'package:application_medicines/medication_controller.dart';
import 'package:application_medicines/medication.dart';

class MedicationListScreen extends StatelessWidget {
  final MedicationController medicationController =
      Get.find<MedicationController>();

  MedicationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Medicamentos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Get.find<AuthController>().logout(),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: medicationController.medications.length,
          itemBuilder: (context, index) {
            final medication = medicationController.medications[index];
            return MedicationCard(medication: medication);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add-medication'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  final Medication medication;
  final MedicationController medicationController = Get.find();

  MedicationCard({super.key, required this.medication});

  @override
  Widget build(BuildContext context) {
    final isPastDue = DateTime.now().isAfter(medication.time) && !medication.taken;

    return Card(
      margin: const EdgeInsets.all(8.0),
      color: isPastDue ? Colors.red.shade100 : null,
      child: ListTile(
        title: Text(medication.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dosis: ${medication.dosage}'),
            Text(
              'Hora: ${medication.time.hour.toString().padLeft(2, '0')}:${medication.time.minute.toString().padLeft(2, '0')}',
            ),
            Text(
              medication.taken ? '✅ Tomado' : '⏱️ Pendiente',
              style: TextStyle(
                color: medication.taken ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            medication.taken ? Icons.check_box : Icons.check_box_outline_blank,
            color: medication.taken ? Colors.green : null,
          ),
          onPressed: () async {
            final updated = medication.copyWith(taken: !medication.taken);
            await medicationController.updateMedication(updated);
          },
        ),
        onTap: () => Get.toNamed('/edit-medication/${medication.id}'),
      ),
    );
  }
}
