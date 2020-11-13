part of 'noticias_bloc.dart';

abstract class NoticiasState extends Equatable {
  const NoticiasState();
  
  @override
  List<Object> get props => [];
}

class NoticiasInitial extends NoticiasState {}
class NoticiasSuccessState extends NoticiasState {
  final List<Noticia> noticiasSportList;
  final List<Noticia> noticiasBuisnessList;

  NoticiasSuccessState({@required this.noticiasSportList,@required this.noticiasBuisnessList});
  @override
  List<Object> get props => [noticiasSportList,noticiasBuisnessList];
}
class NoticiasErrorState extends NoticiasState {
  final String messege;

  NoticiasErrorState({@required this.messege});
  
}
