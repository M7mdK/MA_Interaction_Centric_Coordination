// Agent companyQ1

/* Initial beliefs and rules */

client(giacomo, 20).
client(andrei, 30).
skill(plumbing).
/* Initial goals */

/* Plans */

//Q7-8-9-10:
/*
+!needDelay(S,D) : skill(X) & S == X & client(C,V)
  <-
  .send(C, askOne, delay_limit(DL));	//ask the client what is his acceptable delay
  .print("Recieved the delay_limit value from the client: " , C);
  ?proposeDelay(C,S,D).
   
+?proposeDelay(C,S,D) : delay_limit(DL) & DL > D	
	<- 
	.print("Asking the client to update his tolerance (DL>D)");
	.send(C, achieve , updateTolerance(D)).
	
	
-?proposeDelay(C,S,D) <- .print("Failure in completing the task for agent: " , C).	
*/

//Q11:
+!needDelay(S,D) : skill(X) & S == X
  <-
  for(client(C,V)){
  	.send(C, askOne, delay_limit(DLL));
  	.print("Recieved the delay_limit value from the client: " , C);
  };
  .wait(2000);	//wait for all the clients to send their values (Because sometimes they are being few milliseconds late)
  !greatestDelayLimit(S,D).
	
+!greatestDelayLimit(S,D)
	<-
	.findall(Y,delay_limit(Y),L);
	.print("delay_limit values sent by all the clients: " , L);
	.max(L,M);
	?proposeDelay(S,D,M).

+?proposeDelay(S,D,DL) : delay_limit(DL)[source(C)] & DL > D	
	<- 
	.print("The greatest delay_limit value: " , DL , " Corresponds to cleint: " , C);
	.print("Asking the client to update his tolerance (DL>D)");
	.send(C, achieve , updateTolerance(D));
	-delay_limit(_)[source(C)].	//It is very important to remove the old delay_limit value of this client from the companyA belief base
								//in case another delay is required after this one (during the same run) 
//Example: companyA asks for delay of "13" then andie (greatest delay_limit = 20) will take this delay, his delay_limit becomes 7
//If during the same run, companyA asks again for a delay of value "9" then this time giacomo (delay_limit=10) should take it.
//If we don't delete the old belief then we will still have delay_limit[source(andrei)] with is wrong.
	
	
-?proposeDelay(S,D,DL) : delay_limit(DL)[source(C)]
	<-
	.print("Failure in completing the task for agent: " , C).	
	


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }