// Agent companyQ2

/* Initial beliefs and rules */
client(giacomo, 20).
client(andrei, 30).
skill(plumbing).
delay_limit(giacomo, 30).

penality(andrei, 130).

/* Initial goals */

!start.		//For delay_limit request update
!startP.	//For penalty request update

/* Plans */

+!start : client(C,V) & skill(S) & delay_limit(C, D)
  <-
  .print("sending a request");
  .send(C, achieve, requestManagement(update,limit_delay,S,D))
  .at("now +5 seconds", {+!handle}).	//.at will wait 5 seconds, so that handle is triggered only when infrom_done or failure message is already recieved
  
+!handle : inform_done <- .print("Recieved inform_done successfully").
	
+!handle : failure <- .print("Recieved failure event successfully!").


//Q5:
+!startP : client(C,V) & skill(S) & penality(C, P)
  <-
  .print("sending a Penality request");
  .send(C, achieve, requestManagementP(update,penality,S,P))
  .at("now +5 seconds", {+!handleP}).	//.at will wait 5 seconds, so that handle is triggered only when infrom_done or failure message is already recieved
  
+!handleP : inform_done_p <- .print("Recieved inform_done_p successfully").
	
+!handleP : failure_p <- .print("Recieved failure_p event successfully!").




{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }