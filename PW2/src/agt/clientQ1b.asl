// Agent clientQ1b

/* Initial beliefs and rules */
delay_limit(20).
penalty(plumbing, 50).

/* Initial goals */

/* Plans */

+!updateTolerance(V) :
    delay_limit(L) & L > V
	<-
	-+delay_limit(L-V);
	.print("updated tolerance, my new delay_limit is: " , L-V).
	
//If the original plan failed, this one will be executed, so that No Failure occurs:
+!updateTolerance(V) : delay_limit(L) & L <= V
	<-
	.print("Failed to update tolerance: b").
   
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }