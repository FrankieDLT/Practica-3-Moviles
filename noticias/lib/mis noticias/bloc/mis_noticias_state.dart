part of 'mis_noticias_bloc.dart';

abstract class MisNoticiasState extends Equatable {
  const MisNoticiasState();
  
  @override
  List<Object> get props => [];
}

class MisNoticiasInitial extends MisNoticiasState {}
class NoticiasDescargadasState extends MisNoticiasState {}
class NoticiasErrorState extends MisNoticiasState {
  final String errormessage;

  NoticiasErrorState({@required this.errormessage});
  @override
  List<Object> get props => [errormessage];

}
class NoticiasCreadaState extends MisNoticiasState {}
class ImagenCargadaState extends MisNoticiasState {
  final File imagen;

  ImagenCargadaState({@required this.imagen});
  @override
  List<Object> get props => [imagen];
}
