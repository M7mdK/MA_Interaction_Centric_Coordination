// Agent clientQ2 in project test

/* Initial beliefs and rules */
knowledge(limit_delay,plumbing, 50).
knowledge(penality, plumbing, 100).
action(update).
/* Initial goals */

/* Plans */

 +!requestManagement(A,K,S,D) : action(A) & knowledge(K,S,DL)
 	<-
 	.send(companyA, tell, agree);
 	.print("Sending Agreement");
 	!decide(K,S,D,DL).
 	
+!requestManagement(A,K,S,D)
	<-
	 .send(companyA, tell, ~agree);
	 .print("Sending refusale").

+!decide(K,S,D,DL) : DL > D
	<-
	-+knowledge(K,S,DL-D);
	 .send(companyA, tell, inform_done);
 	.print("Sending inform_done message").
 	
+!decide(K,S,D,DL) : DL <= D
	<-
	.send(companyA, tell, failure);
 	.print("Sending failure message").
 	
 	
 //Q5:
 +!requestManagementP(A,K,S,P) : action(A) & knowledge(K,S,PL)
 	<-
 	.send(companyA, tell, agreeP);
 	.print("Sending Agreement on penalty");
 	!decideP(K,S,P,PL).
 	
+!requestManagementP(A,K,S,P)
	<-
	 .send(companyA, tell, ~agreeP);
	 .print("Sending refusale on penalty").

+!decideP(K,S,P,PL) : PL < P
	<-
	-+knowledge(K,S,P-PL);
	 .send(companyA, tell, inform_done_p);
 	.print("Sending inform_done_p message").
 	
+!decideP(K,S,P,PL) : PL >= P
	<-
	.send(companyA, tell, failure_p);
 	.print("Sending failure_p message").

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }