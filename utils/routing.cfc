<cfcomponent>
  <cffunction name="init" access="public" returntype="void" output="false">
  </cffunction>

  <cffunction name="breakRoute" access="public" returntype="array" output="false">
    <cfargument name="route" type="string" required="false" default="">
    <cfset var route = ListToArray(arguments.route,".")>
    <cfset var routeLen = ArrayLen(route)>

    <cfset var dir = routeLen gt 1? ArraySlice(route,1,routeLen-1): []>
    <cfset var file = routeLen gt 1? route[-1]: routeLen gt 0? route[1]: "">

    <cfreturn [dir,file]>
  </cffunction>

  <cffunction name="getAbsoluteFilePath" access="public" returntype="string" output="true">  
    <cfargument name="filePath" type="array" required="true">
    <cfargument name="fileExt" type="string" required="true">

    <cfset var filePathLen = ArrayLen(arguments.filePath)>
    <cfif filePathLen lt 1> <cfreturn ""> </cfif>

    <cfset var filePath2 = ["{web-root-directory}"]>
    <cfloop index="p" array=#arguments.filePath#>
      <cfset ArrayAppend(filePath2,p)>
    </cfloop>

    <cfset var filePathExpanded = ExpandPath( ArrayToList(filePath2,"/") )>
    <cfreturn "#filePathExpanded#.#arguments.fileExt#"> 
  </cffunction>

  <cffunction name="isCFCExists" access="public" returntype="boolean" output="true">  
    <cfargument name="path" type="array" required="true">
    <cfset cfcPath = getAbsoluteFilePath(arguments.path,"cfc")>
    <cfif Len(cfcPath) eq 0> <cfreturn false> </cfif>

    <cfreturn FileExists(cfcPath)>
  </cffunction>

  <cffunction name="isCFCFunctionExists" access="public" returntype="boolean" output="true">  
    <cfargument name="path" type="array" required="true">
    <cfargument name="method" type="string" required="true">
    <cfset var isExistsCFC = isCFCExists(path)>
    <cfset var isExistsCFCFunction = false>

    <cfif isExistsCFC>
      <cfset var metadata = getComponentMetadata(ArrayToList(path,"."))>
      <cfif metadata.type eq "component">
        <cfloop index="f" array=#metadata.functions#>
          <cfset isExistsCFCFunction = f.name eq arguments.method>
          <cfif isExistsCFCFunction eq true>
            <cfbreak>
          </cfif>
        </cfloop>
      </cfif>
    </cfif>

    <cfreturn isExistsCFCFunction>
  </cffunction>

</cfcomponent>
