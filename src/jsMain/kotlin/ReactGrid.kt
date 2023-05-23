@file:Suppress("unused")
@file:JsModule("ag-grid-react") //https://www.npmjs.com/package/ag-grid-community
@file:JsNonModule

import react.*

@JsName("AgGridReact")
external val agGreed: ComponentClass<ReactGridProps>

external interface ReactGridProps : Props {
    var columnDefs: Array<Any>
    var rowData: Array<Any>
    var context: Map<String, String>
    var rowDragManaged: Boolean
    var animateRows: Boolean
    var headerHeight: Int
    var rowHeight: Int
    var rowSelection: String
    var editType: String? // "fullRow"
    var stopEditingWhenCellsLoseFocus: Boolean?
    var getRowClass: Any?
    var rowClassRules: Any?
    var paginationAutoPageSize: Boolean
    var pagination: Boolean
    var undoRedoCellEditing: Boolean
    var undoRedoCellEditingLimit: Int
    var enableRangeSelection: Boolean
    var enableRangeHandle: Boolean
    var suppressClickEdit: Boolean
    var enableFillHandle: Boolean

    // events https://www.ag-grid.com/documentation/react/grid-events/
    var onGridReady: Any?
    var onCellValueChanged: Any?
    var onCellClicked: Any?
    var onCellDoubleClicked: Any?
    var onCellMouseOver: Any?
    var onSortChanged: Any?
    var onCellKeyPress: Any?
    var onCellKeyDown: Any?
    var onRowSelected: Any?
}

external interface ParamsAG {
    val type: String
    val event: dynamic
    val column: Column
    val columns: Array<Column>
    val rowIndex: Int
    val colDef: ColDefAG
    val api: ApiAG
    val data: dynamic
    val context: dynamic
    val node: Node
    val newValue: dynamic
    val oldValue: dynamic
    val columnApi: ColumnApiAG
}

external interface ColDefAG {
    val editable: Boolean
    val field: Any
    val cellEditor: String
}

external interface ApiAG {
    val isFilterActive: () -> Boolean
    val redrawRows: (Array<Any>?) -> Unit
    val getDisplayedRowAtIndex: (Int) -> Node
    val getDisplayedRowCount: Int
    val selectAll: () -> Unit
    val deselectAll: () -> Unit
    val getSelectedRows: () -> Array<Any>
    val getSelectedNodes: () -> Array<Any>
    val paginationGoToLastPage: () -> Unit
    val setFocusedCell: (rowIndex: Int, colKey: String, rowPinned: Any?) -> Unit
    val getFirstDisplayedRow: Node
    val getLastDisplayedRow: Node
}

external interface ColumnApiAG {
    val getAllDisplayedColumns: () -> Array<Column>
    val getAllGridColumns: () -> Array<Column>
}

external interface Node {
    val id: String
    val selected: Boolean
    val data: dynamic
    val setSelected: (Boolean) -> Unit
}

external interface Column {
    val colId: String
    val colDef: ColDefAG
}