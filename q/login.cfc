<cfcomponent>

  <cffunction name="genHash" access="private" returntype="array" output=true>
    <cfargument name="appSecret" type="string" required="true">
    <cfset var t = now()>
    <cfset hguest = hash(t,"sha-512")>
    <cfset hcompose = hash(arguments.appSecret & t,"sha-512")>
    <cfreturn [hguest,hcompose]>
  </cffunction>

</cfcomponent>
