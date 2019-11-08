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
	checker: lone Authority,
	picture: one Picture,
	date: one Date,
	hour: one Hour,
	typeviolation: one TypeViolation,
	plate: one Plate,
	description: one Description,
	position: one Position,
}
abstract sig ViewListViolation{
	violations: set Violation
}
lone sig ViewListViolationUser extends ViewListViolation{
	observer: one User
}
lone sig ViewListViolationAuthority extends ViewListViolation{
	observer: one Authority
}
abstract sig ViewListAccident{
	accidents: Int 
} {accidents >= 0}
lone sig ViewListAccidentUser extends ViewListAccident{
	observer: some User
}
lone sig ViewListAccidentAuthority extends ViewListAccident{
	observer: some Authority,
	suggestion: lone GiveSuggestion
}{#suggestion=1 iff accidents>=3 }
sig GiveSuggestion{}

----------------------------------------------------------------------------------------------------

--Two lists of accidents can't have two different quantities, as both users and authorities can inspect them
fact EqualNumberAccidents{
	no disjoint t1,t2: ViewListAccident | t1.accidents!=t2.accidents
}
--If a list of violation exists, it can see every violation
fact ListViolationAll{
	all v : Violation | all vl: ViewListViolation | v in vl.violations
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
	all d : Description | some v : Violation | d in v.description
}
-- only if a related violation exists
fact ExistancePosition{
	all p : Position | some v : Violation | p in v.position
}
--All CellPhones have to be associated to a User
fact CellPhoneUserConnection{
	all cp: CellPhone | one u: User | cp in u.cellphone
}
fact NoIdWithoutAuthority{
	all i: Id | one a : Authority | i in a.id
}
--each Authority can check only one violation
fact ViolationAuthorityConnection{
	some a: Authority | lone v: Violation | a in v.checker
}
-- each Violation must be checked by one Authority
fact EachViolationIsCheckedByAnAuthority{
	all v: Violation | one a: Authority | a in v.checker
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
	all s : GiveSuggestion | one v : ViewListAccidentAuthority |s in v.suggestion
}


--user's cellphone is unique
assert UserCellPhoneisUnique{
	no disjoint t1,t2 : User | t1!=t2 and t1.cellphone = t2.cellphone
}
--authority's id is unique
assert AuthorityIdIsUnique{
	no disjoint t1,t2 : Authority | t1!=t2 and t1.id = t2.id
}

assert sugg{
	all a: ViewListAccidentAuthority | #a.suggestion=1 iff a.accidents >=3
}

check sugg

--check UserCellPhoneisUnique

--check AuthorityIdIsUnique

pred world1{

	
}

pred world2{}

pred world3{}

pred world4{}

run world1 for 5 but 3 Violation, 0 ViewListViolationUser, 0 ViewListViolationAuthority, 0 ViewListAccidentAuthority, 0 ViewListAccidentUser  










