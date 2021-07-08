import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class CloudStorageInfo {
  final String?  title, totalStorage;
  final int? numOfFiles;

  CloudStorageInfo({
    this.title,
    this.totalStorage,
    this.numOfFiles,
   
  });
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Ventillator",
    numOfFiles: 30,
    totalStorage: "10:00 AM",

  ),
  CloudStorageInfo(
    title: "Dialysis",
    numOfFiles: 30,

    totalStorage: "12:00 PM",

  ),
  CloudStorageInfo(
    title: "Ventillator",
    numOfFiles: 30,
    totalStorage: "10:00 AM",

  ),
  CloudStorageInfo(
    title: "Dialysis",
    numOfFiles: 30,

    totalStorage: "12:00 PM",

  ),
  CloudStorageInfo(
    title: "Deffibrillator",
    numOfFiles: 30,
    totalStorage: "1:00 PM ",
  ),
  CloudStorageInfo(
    title: "Anthesia",
    numOfFiles: 30,
    totalStorage: "2:00 PM",

  ),
];
