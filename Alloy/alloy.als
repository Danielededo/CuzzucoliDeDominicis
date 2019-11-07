sig CellPhone{}
sig User{
	cellphone: one CellPhone
}
sig Id{}
sig Authority{
	id: one Id
}
sig Picture{}
sig Date{}
sig Hour{}
sig TypeViolation{}
sig Plate{}
sig Description{}
sig Position{}
sig Violation{
	sender: one User,
	checker: one Authority,
	picture: one Picture,
	date: one Date,
	hour: one Hour,
	typeviolation: one TypeViolation,
	plate: one Plate,
	description: one Description,
	position: one Position,
}
abstract sig ViewListViolation{
	violations: some Violation
}
one sig ViewListViolationUser extends ViewListViolation{
	observer: one User
}
one sig ViewListViolationAuthority extends ViewListViolation{
	observer: one Authority
}
abstract sig ViewListAccident{
	accidents: some Accident
}
one sig ViewListAccidentsUser extends ViewListAccident{
	observer: some User
}
one sig ViewListAccidentsAuthority extends ViewListAccident{
	observer: some Authority,
	suggestion: lone GiveSuggestion
}
sig Accident{}
sig GiveSuggestion{}
fact ListAccidentAll{
	all a : Accident | one va: ViewListAccident | a in va.accidents
}
fact ListViolationAll{
	all v : Violation | one vl: ViewListViolation | v in vl.violations
}
--A picture is considered only if a related violation exists
fact ExistancePicture{
	all p : Picture | one v : Violation | p in v.picture
}
--A plate is considered only if a related violation exists
fact ExistancePlate{
	all p : Plate  | some v : Violation | p in v.plate
}
--A date is considered only if a related violation exists
fact ExistanceDate{
	all d : Date | some v : Violation | d in v.date
}
--An hour is considered only if a related violation exists
fact ExistanceHour{
	all h : Hour | some v : Violation | h in v.hour
}
--A type is considered if a related violation exists
fact ExistanceTypeViolation{
	all t : TypeViolation | some v : Violation | t in v.typeviolation
}
--A description is considered only if a related violation exists
fact ExistanceDescription{
	all d : Description | one v : Violation | d in v.description
}
-- only if a related violation exists
fact ExistancePosition{
	all p : Position | some v : Violation | p in v.position
}
--All CellPhones have to be associated to a User
fact CellPhoneUserConnection{
	all cp: CellPhone | one u: User | cp in u.cellphone
}
--user's cellphone is unique
fact UserCellPhoneisUnique{
	no disjoint t1,t2 : User | t1.cellphone = t2.cellphone
}
fact NoIdWithoutAuthority{
	all i: Id | one a : Authority | i in a.id
}
--authority's id is unique
fact AuthorityIdIsUnique{
	no disjoint t1,t2 : Authority | t1.id = t2.id
}
--each Violation has only one sender
fact ViolationUserConnection{
	all v: Violation | one u: User | u in v.sender
}
--the same User can report multiple Violations
fact UserViolationConnection{
	some u: User | some v:Violation | u in v.sender
}
-- each Violation must be checked by one Authority
fact EachViolationIsCheckedByAnAuthority{
	all v: Violation | one a: Authority | a in v.checker
}
--the same Plate can be subject to multiple Violations
fact PlateViolationConnection{
	some p: Plate | some v:Violation | p in v.plate
}
--no vehicles on the same spot at the same time
fact NoBusySpots{
	no disjoint t1,t2: Violation | t1.plate != t2.plate and t1.position = t2.position and t1.date = t2.date and t1.hour = t2.hour
}
--different violations with same plates can't be done at the same time
fact NoRepetition{
	no disjoint t1,t2: Violation | t1.plate = t2.plate and t1.date = t2.date and t1.hour = t2.hour
}
--unique picture for violation
fact UniquePicture{
	no disjoint t1,t2: Violation | t1.picture = t2.picture
}
--exists only if a related Accident exists
fact ExistanceSuggestion{
	all s : GiveSuggestion | one v : ViewListAccidentsAuthority |s in v.suggestion
}

pred world1{
	#User= 4
	#Violation=2
}

run world1 for 4 but 2 Violation








