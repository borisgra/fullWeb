@file:Suppress("unused")
@file:JsModule("ag-grid-react") //https://www.npmjs.com/package/ag-grid-community
@file:JsNonModule

import react.*

@JsName("AgGridReact")
external var agGreed: ComponentClass<ReactGridProps>

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
    var type: String
    var event: dynamic
    var column: Column
    var columns: Array<Column>
    var rowIndex: Int
    var colDef: ColDefAG
    var api: ApiAG
    var data: dynamic
    var context: dynamic
    var node: Node
    var newValue: dynamic
    var oldValue: dynamic
}

external interface ColDefAG {
    var editable: Boolean
    var field: Any
    var cellEditor: String
}

external interface ApiAG {
    var isFilterActive: () -> Boolean
    var redrawRows: () -> Unit
    var getDisplayedRowAtIndex: (Int) -> Node
    var getDisplayedRowCount: Int
    var selectAll: () -> Unit
    var deselectAll: () -> Unit
    var getSelectedRows: () -> Array<Any>
    var getSelectedNodes: () -> Array<Any>
    var paginationGoToLastPage: () -> Unit
    var setFocusedCell: (rowIndex: Int, colKey: String, rowPinned: Any?) -> Unit
    var getFirstDisplayedRow: Node
    var getLastDisplayedRow: Node
    var getAllGridColumns: () -> Array<Column>
    var getAllDisplayedColumns: () -> Array<Column>
}

external interface Node {
    var id: dynamic
    var selected: Boolean
    var data: dynamic
    var setSelected: (Boolean) -> Unit
}

external interface Column {
    var colId: String
    var colDef: ColDefAG
}