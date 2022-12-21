//
// import 'entities/event.dart';
//
// // TODO: events need...
// // a stream id
// // an action type
// // a data type
// // a command type
// // the developer needs to be able to define these dynamically and register them.
// // maybe I can use the code generator to help with this.
//
// /// A utility for generating events with the proper data
// class EventFactory {
//   static Event addMember({
//     required String groupStreamId,
//     required AddMemberData data,
//   }) {
//     return Event(
//       streamId: groupStreamId,
//       actionType: EventActionType.addMember,
//       data: data.toJson(),
//     );
//   }
//
//   static Event removeMember({
//     required String groupStreamId,
//     required RemoveMemberData data,
//   }) {
//     return Event(
//       streamId: groupStreamId,
//       actionType: EventActionType.removeMember,
//       data: data.toJson(),
//     );
//   }
//
//   static Event createGroup({
//     required String groupStreamId,
//     required CreateGroupData data,
//   }) {
//     return Event(
//       streamId: groupStreamId,
//       actionType: EventActionType.createGroup,
//       data: data.toJson(),
//     );
//   }
//
//   static Event assignParentGroup({
//     required String groupStreamId,
//     required AssignParentGroupData data,
//   }) {
//     return Event(
//       streamId: groupStreamId,
//       actionType: EventActionType.assignParentGroup,
//       data: data.toJson(),
//     );
//   }
//
//   static Event assignLeader({
//     required String groupStreamId,
//     required AssignLeaderData data,
//   }) {
//     return Event(
//       streamId: groupStreamId,
//       actionType: EventActionType.assignLeader,
//       data: data.toJson(),
//     );
//   }
//
//   static Event createPerson({
//     required String personStreamId,
//     required CreatePersonData data,
//   }) {
//     return Event(
//       streamId: personStreamId,
//       actionType: EventActionType.createPerson,
//       data: data.toJson(),
//     );
//   }
//
//   static Event deleteGroup({required String groupStreamId}) {
//     return Event(
//       streamId: groupStreamId,
//       actionType: EventActionType.deleteGroup,
//     );
//   }
//
//   static Event deletePerson({required String personStreamId}) {
//     return Event(
//       streamId: personStreamId,
//       actionType: EventActionType.deletePerson,
//     );
//   }
//
//   static Event updateGroup({
//     required String groupStreamId,
//     required UpdateGroupData data,
//   }) {
//     return Event(
//       streamId: groupStreamId,
//       actionType: EventActionType.updateGroup,
//       data: data.toJson(),
//     );
//   }
//
//   static Event updatePerson({
//     required String personStreamId,
//     required UpdatePersonData data,
//   }) {
//     return Event(
//       streamId: personStreamId,
//       actionType: EventActionType.updatePerson,
//       data: data.toJson(),
//     );
//   }
//
//   static Event createLeaderGroup({
//     required String groupStreamId,
//     required CreateLeaderGroupData data,
//   }) {
//     return Event(
//       streamId: groupStreamId,
//       actionType: EventActionType.createLeaderGroup,
//       data: data.toJson(),
//     );
//   }
//
//   static Event deleteLeaderGroup({required String groupStreamId}) {
//     return Event(
//       streamId: groupStreamId,
//       actionType: EventActionType.deleteLeaderGroup,
//     );
//   }
//
//   static Event updateLeaderGroup({
//     required String groupStreamId,
//     required UpdateLeaderGroupData data,
//   }) {
//     return Event(
//       streamId: groupStreamId,
//       actionType: EventActionType.updateLeaderGroup,
//       data: data.toJson(),
//     );
//   }
// }
