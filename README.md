<H2 style="text-align: center;">FullStack Web Applications with React and Kotlin JS and NPM(ag-grid)<H2/>
<H4>
<div>kotlin:</div>

<a href = "https://kotlinlang.org/docs/js-get-started.html#create-an-application">js-get-started</a><br/>
<a href = "https://play.kotlinlang.org/hands-on/Full Stack Web App with Kotlin Multiplatform/01_Introduction">Full Stack Web App with Kotlin Multiplatform </a><br/>
<a href = "https://play.kotlinlang.org/hands-on/Building Web Applications with React and Kotlin JS/01_Introduction">Building Web Applications with React and Kotlin JS </a>
<div>git:</div>
<a href = "https://github.com/kotlin-hands-on/jvm-js-fullstack">jvm-js-fullstack</a><br/>
<a href = "https://github.com/kotlin-hands-on/web-app-react-kotlin-js-gradle/tree/07-using-external-rest-api">web-app-react-kotlin-js-gradle</a>
<div>npm:</div>
<a href = "https://www.npmjs.com/package/ag-grid-community">ag-grid-community</a><br/>
<a href = "https://www.npmjs.com/package/react-share">react-share</a>

<H2 style="text-align: center;">Example </H2>
<a href="https://query-m.herokuapp.com">https://query-m.herokuapp.com</a>

<H2 style="text-align: center;">Look and modify ANY view from ANY base (PGSql)</H2>
<H4 style="text-align: center;">Environment (Config Vars in Heroku) </H4>
          <div>key="ADMIN_PASSW" value="???????"</div>
          <div>key="DATABASE_TIMEOUT" value="15"</div>
          <div>key="DATABASE_URL_animal" value="postgres://demo:password@p-xj6qj8i1hx.qsbilba3hlgp1vqr.biganimal.io:5432/chinook"</div>
          <div>key="DATABASE_URL_local" value="postgres://foUser:??????@localhost:54320/fo2_eu"</div>
          <div>key="DATABASE_URL_querym" value="postgres://user_name:password@host:port/dara_base"</div>
          <div>key="QUERY_BD" value="querym" /></div>
          <div>key="q" value="v_history_last50_ro" /></div>
<H4 style="text-align: center;">Request description look in view QUERY_BD (menu/Construction/development/Queries) </H4>

<H2 style="text-align: center;">Help </H2>
<div>Ctrl+z - Undo</div>
<div>Ctrl+Shift+-z - Redo</div>
<div>Tab - Tabulate right</div>
<div>Shift+Tab - Tabulate left</div>
<div>Select region - use mouse or arrow and Ctrl or Shift</div>
<div>Ctrl+c - copy region</div>
<div>Ctrl+v - paste region</div>
<br/>

<div>Dbl+click on first column - delete row</div>
<div>click on cell - edit cell <b>if pressed Edit button</b></div>
<div>flip pages - in the right down corner</div>
<br/>
<p>Parameters:</p>
<div>q - starts with concret request (name request in list requests or route request)</div>
<div>m=hide - hide All menus</div>
<div>s=hide - hide Service menu</div>
<div>v - name view in base for list requests </div>
<div>w - wher for view(in base) for list requests (?w=and left(submenu,3)='Big')</div>
<div>Example:</div>
<div><a href="https://querys-pg.herokuapp.com?q=https://www.ag-grid.com/example-assets/olympic-winners.json&m=hide">
    querys-pg.herokuapp.com?q=https://www.ag-grid.com/example-assets/olympic-winners.json&m=hide
</a></div>
<div><a href="https://querys-pg.herokuapp.com?q=olympic-winners_ro&m=hide">
    querys-pg.herokuapp.com?q=olympic-winners_ro&m=hide
</a></div>
<br/>
<div>if heads contains '#' - new tab in explorer:</div>
<div> Use column SQL in query table for fluent query(select... from ...)</div>
<div> fields that start with "_" are not saved</div>
<br/>
<p>Columns Property's:</p>
<div>
    headerName<br/>
    field<br/>
    filter<br/>
    sortable<br/>
    editable<br/>
    type<br/>
    resizable<br/>
    width<br/>
    pinned<br/>
    rowDrag<br/>
    checkboxSelection<br/>
    cellEditor<br/>
    cellEditorParams<br/>
    colSpan<br/>
    flex<br/>
    headerTooltip<br/>
    wrapText<br/>
    autoHeight<br/>
    minWidth<br/>
    headerCheckboxSelection<br/>
    headerCheckboxSelectionFilteredOnly<br/>
</div>