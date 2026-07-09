import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../domain/i_trekking_repository.dart';
import '../domain/trekking_location.dart';

// Events
abstract class TrekkingEvent extends Equatable {
  const TrekkingEvent();
  @override
  List<Object> get props => [];
}

class FetchTrekkingLocations extends TrekkingEvent {}

// State
abstract class TrekkingState extends Equatable {
  const TrekkingState();
  @override
  List<Object> get props => [];
}

class TrekkingInitial extends TrekkingState {}

class TrekkingLoading extends TrekkingState {}

class TrekkingLoaded extends TrekkingState {
  final List<TrekkingLocation> locations;
  const TrekkingLoaded(this.locations);
  @override
  List<Object> get props => [locations];
}

class TrekkingError extends TrekkingState {
  final String message;
  const TrekkingError(this.message);
  @override
  List<Object> get props => [message];
}

// Bloc
class TrekkingBloc extends Bloc<TrekkingEvent, TrekkingState> {
  final ITrekkingRepository repository;

  TrekkingBloc({required this.repository}) : super(TrekkingInitial()) {
    on<FetchTrekkingLocations>(_onFetchLocations);
  }

  Future<void> _onFetchLocations(
    FetchTrekkingLocations event,
    Emitter<TrekkingState> emit,
  ) async {
    emit(TrekkingLoading());
    try {
      final locations = await repository.getLocations();
      emit(TrekkingLoaded(locations));
    } catch (e) {
      emit(const TrekkingError('Failed to fetch trekking locations'));
    }
  }
}
