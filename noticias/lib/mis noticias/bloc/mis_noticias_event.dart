part of 'mis_noticias_bloc.dart';

abstract class MisNoticiasEvent extends Equatable {
  const MisNoticiasEvent();

  @override
  List<Object> get props => [];
}

class CrearNoticiasEvent extends MisNoticiasEvent{
  final String titulo;
  final String descripcion;
  final String autor;
  final String fuente;

  CrearNoticiasEvent({@required this.titulo,@required this.descripcion,@required this.autor,@required this.fuente});
  
  @override
  List<Object> get props => [titulo,descripcion,autor,fuente];
}

class LeerNoticiasEvent extends MisNoticiasEvent{
  @override
  List<Object> get props => [];
}

class CargarImagenEvent extends MisNoticiasEvent{
 final bool camera;

  CargarImagenEvent({@required this.camera});
  @override
  List<Object> get props => [camera];
}