import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


class Utils
{
  static dynamic toDateTime(Timestamp value)
  {
    if(value == null) {
      return null;
    }

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date)
  {
    if(date == null){
      return null;
    }

    return date.toUtc();
  }

  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>> transformer<T>(
      T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>.fromHandlers(
        handleData: (QuerySnapshot<Map<String, dynamic>> data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final objects = snaps.map((json) => fromJson(json)).toList();

          sink.add(objects);
        },
      );
}