import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/rooms.dart';
import '../services/room_repository.dart';
import 'app_providers.dart';

final roomRepositoryProvider = Provider<RoomRepository>(
  (ref) => RoomRepository(),
);

final roomsProvider = StreamProvider<List<Room>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value(const []);
  return ref.watch(roomRepositoryProvider).watchRooms(user.id);
});

final roomProvider = StreamProvider.family<Room?, String>((ref, roomId) {
  return ref.watch(roomRepositoryProvider).watchRoom(roomId);
});

final roomOptionsProvider =
    StreamProvider.family<List<RestaurantOption>, String>((ref, roomId) {
  return ref.watch(roomRepositoryProvider).watchOptions(roomId);
});

final roomParticipantsProvider =
    StreamProvider.family<List<RoomParticipant>, String>((ref, roomId) {
  return ref.watch(roomRepositoryProvider).watchParticipants(roomId);
});

final roomVotesProvider =
    StreamProvider.family<List<RoomVote>, String>((ref, roomId) {
  return ref.watch(roomRepositoryProvider).watchVotes(roomId);
});

final roomNotesProvider =
    StreamProvider.family<List<RoomNote>, String>((ref, roomId) {
  return ref.watch(roomRepositoryProvider).watchNotes(roomId);
});

final crewsProvider = StreamProvider<List<Crew>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value(const []);
  return ref.watch(roomRepositoryProvider).watchCrews(user.id);
});

final crewMembersProvider =
    StreamProvider.family<List<CrewMember>, String>((ref, crewId) {
  return ref.watch(roomRepositoryProvider).watchCrewMembers(crewId);
});

final roomInvitationsProvider = StreamProvider<List<RoomInvitation>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null || user.email.isEmpty) {
    return Stream.value(const []);
  }
  return ref.watch(roomRepositoryProvider).watchRoomInvitations(user.email);
});

final crewInvitationsProvider = StreamProvider<List<CrewInvitation>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null || user.email.isEmpty) {
    return Stream.value(const []);
  }
  return ref.watch(roomRepositoryProvider).watchCrewInvitations(user.email);
});
