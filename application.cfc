<cfcomponent displayname="application" output="true">

<!--- application handler --->
  <cffunction name="onApplicationStart" access="public" returntype="boolean" output="false">  
    <cfreturn true> 
  </cffunction>  

  <cffunction name="onApplicationEnd" access="public" returntype="void" output="false">  
    <cfargument name="applicationScope" type="struct" required="true">
  </cffunction>  


<!--- session handler --->
  <cffunction name="onSessionStart" access="public" returntype="void" output="false">  
    <cfreturn ""> 
  </cffunction>  

  <cffunction name="onSessionEnd" access="public" returntype="void" output="false">  
    <cfargument name="sessionScope" type="struct" required="true">
    <cfargument name="applicationScope" type="struct" required="true">
    <cfreturn ""> 
  </cffunction>  


<!--- request handler --->
  <cffunction name="onRequestStart" access="public" returntype="boolean" output="true">  
    <cfargument name="targetPage" type="string" required="true">
    <cfreturn true> 
  </cffunction>  

  <cffunction name="onRequest" access="public" returntype="void" output="true">  
    <cfargument name="targetPage" type="string" required="true">
    <cfset var routing = CreateObject("component","utils.routing")>
    <cfset var route = routing.breakRoute(url.route)>

<!--- TODO: remove once done --->
    <cfset application.vars = getVars()>

    <cfset var targetComponent = "">
    <cfset var result = "">
    <cfif routing.isCFCFunctionExists(route[1],route[2])>
      <cfset targetComponent = CreateObject("component",ArrayToList(route[1],"."))>
      <cfset result = targetComponent[route[2]](argumentCollection=form)> 
    </cfif>

    <cfcontent type="application/json" variable=#toBinary(toBase64( serializeJson(result) ))#>
  </cffunction>  

  <cffunction name="onCFCRequest" access="public" returntype="void" output="true">  
    <cfargument name="cfcName" type="string" required="false">
    <cfargument name="method" type="string" required="false">
    <cfargument name="struct" type="args" required="false">

    <cfdump var=#cfcName#>
    <cfdump var=#method#>
  </cffunction>  

  <cffunction name="onRequestEnd" access="public" returntype="void" output="true">  
    <cfreturn "">
  </cffunction>  


<!--- error handler --->
  <cffunction name="onAbort" access="public" returntype="void" output=true>
    <cfargument name="targetPage" type="string" required="true">
    <cfdump var=#targetPage#>
  </cffunction>

  <cffunction name="onError" access="public" returntype="void" output=true>
    <cfargument name="exception" type="any" required="true">
    <cfargument name="eventName" type="string" required="true">
    <cfdump var=#eventName#>
    <cfdump var=#exception#>
  </cffunction>

  <cffunction name="onMissingTemplate" access="public" returntype="boolean" output=true>
    <cfargument name="targetPage" type="string" required="true">
    <cfdump var=#targetPage#>

    <cfreturn true>
  </cffunction>


<!--- custom functions --->
  <cffunction name="getVars" access="public" returntype="struct" output=true>
    <cfset var appvars = {
      db = "mata_mata"
      ,hsecret = "something"
    }>
    <cfreturn appvars>
  </cffunction>


</cfcomponent>
