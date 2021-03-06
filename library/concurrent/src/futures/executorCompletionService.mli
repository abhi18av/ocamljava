(*
 * This file is part of OCaml-Java library.
 * Copyright (C) 2007-2015 Xavier Clerc.
 *
 * OCaml-Java library is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * OCaml-Java library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *)

(** Helper entities for thread pool executors. *)


type t = java'util'concurrent'ExecutorCompletionService java_instance
(** The type of completion services, providing utilities to wait for
    future completions. *)

val make : ThreadPoolExecutor.t -> t
(** Returns a new completion service based on the passed thread pool;
    see {java java.util.concurrent.ExecutorCompletionService#ExecutorCompletionService(java.util.concurrent.Executor)}. *)

val poll : t -> 'a Future.t option
(** Returns (and removes from the service) a completed task if any, or
    returns [None]; see {java java.util.concurrent.ExecutorCompletionService#poll()}. *)

val poll_time : t -> java_long -> TimeUnit.t -> 'a Future.t option
(** [poll_time s t u] is similar to [pool s], except that the current
    thread will at most wait for [t] (time value whose unit is [u]); see
    {java java.util.concurrent.ExecutorCompletionService#poll(long, java.util.concurrent.TimeUnit)}.

    @raise Java_exception if the thread is interrupted *)

val submit : t -> ('a -> 'b) -> 'a -> 'b Future.t
(** Same as {!ThreadPoolExecutor.submit}. *)

val take : t -> 'a Future.t
(** Waits for a task to complete, and returns it; see
    {java java.util.concurrent.ExecutorCompletionService.html#take()}.

    @raise Java_exception if the thread is interrupted *)


(** {6 Null value} *)

val null : t
(** The [null] value. *)

external is_null : t -> bool =
  "java is_null"
(** [is_null obj] returns [true] iff [obj] is equal to [null]. *)

external is_not_null : t -> bool =
  "java is_not_null"
(** [is_not_null obj] returns [false] iff [obj] is equal to [null]. *)


(** {6 Miscellaneous} *)

val wrap : t -> t option
(** [wrap obj] wraps the reference [obj] into an option type:
    - [Some x] if [obj] is not [null];
    - [None] if [obj] is [null]. *)

val unwrap : t option -> t
(** [unwrap obj] unwraps the option [obj] into a bare reference:
    - [Some x] is mapped to [x];
    - [None] is mapped to [null]. *)
