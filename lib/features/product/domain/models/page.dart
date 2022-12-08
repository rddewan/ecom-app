
import 'package:equatable/equatable.dart';

class Page extends Equatable {
  final int  currentPage;
  final int perPage;
  final int lastPage;
  final int total;

  const Page({
    required this.currentPage, 
    required this.perPage, 
    required this.lastPage, 
    required this.total,
  });


  @override
  List<Object> get props => [currentPage, perPage, lastPage, total];

  @override  
  bool? get stringify => true;
}
