// Type definitions for Kendo UI

declare module kendo {
    function bind(selector: string, viewModel: any, namespace?: any): void;
    function bind(element: JQuery, viewModel: any, namespace?: any): void;
    function bind(element: Element, viewModel: any, namespace?: any): void;
    function culture(value: string): void;
    function culture(): {
        name: string;
        calendar: {
            AM: string[];
            PM: string[];
            days: {
                names: string[];
                namesAbbr: string[];
                namesShort: string[];
                firstDay: number;
            };
            months: {
                names: string[];
                namesAbbr: string[];
            };
            patterns: {
                D: string;
                F: string;
                G: string;
                M: string;
                T: string;
                Y: string;
                d: string;
                g: string;
                m: string;
                s: string;
                t: string;
                u: string;
                y: string;
            };
            twoDigitYearMax: number;
        };
        calendars: {
            standard: {
                AM: string[];
                PM: string[];
                days: {
                    names: string[];
                    namesAbbr: string[];
                    namesShort: string[];
                    firstDay: number;
                };
                months: {
                    names: string[];
                    namesAbbr: string[];
                };
                patterns: {
                    D: string;
                    F: string;
                    G: string;
                    M: string;
                    T: string;
                    Y: string;
                    d: string;
                    g: string;
                    m: string;
                    s: string;
                    t: string;
                    u: string;
                    y: string;
                };
                twoDigitYearMax: number;
            };
        };
        numberFormat: {
            currency: {
                decimals: number;
                groupSize: number[];
                pattern: string[];
                symbol: string;
            };
            decimals: number;
            groupSize: number[];
            pattern: string[];
            percent: {
                decimals: number;
                groupSize: number[];
                pattern: string[];
                symbol: string;
            };
        };
    };

    var cultures: {[culture:string] : {
        name?: string;
        calendar?: {
            AM: string[];
            PM: string[];
            days: {
                names: string[];
                namesAbbr: string[];
                namesShort: string[];
                firstDay: number;
            };
            months: {
                names: string[];
                namesAbbr: string[];
            };
            patterns: {
                D: string;
                F: string;
                G: string;
                M: string;
                T: string;
                Y: string;
                d: string;
                g: string;
                m: string;
                s: string;
                t: string;
                u: string;
                y: string;
            };
            twoDigitYearMax: number;
        };
        calendars?: {
            standard: {
                AM: string[];
                PM: string[];
                days: {
                    names: string[];
                    namesAbbr: string[];
                    namesShort: string[];
                    firstDay: number;
                };
                months: {
                    names: string[];
                    namesAbbr: string[];
                };
                patterns: {
                    D: string;
                    F: string;
                    G: string;
                    M: string;
                    T: string;
                    Y: string;
                    d: string;
                    g: string;
                    m: string;
                    s: string;
                    t: string;
                    u: string;
                    y: string;
                };
                twoDigitYearMax: number;
            };
        };
        numberFormat?: {
            currency: {
                decimals: number;
                groupSize: number[];
                pattern: string[];
                symbol: string;
            };
            decimals: number;
            groupSize: number[];
            pattern: string[];
            percent: {
                decimals: number;
                groupSize: number[];
                pattern: string[];
                symbol: string;
            };
        };
    }};

    function destroy(selector: string): void;
    function destroy(element: Element): void;
    function destroy(element: JQuery): void;
    function format(format: string, ...values: any[]): string;

    function fx(selector: string): effects.Element;
    function fx(element: Element): effects.Element;
    function fx(element: JQuery): effects.Element;

    function htmlEncode(value: string): string;
    function init(selector: string, ...namespaces: any[]): void;
    function init(element: JQuery, ...namespaces: any[]): void;
    function init(element: Element, ...namespaces: any[]): void;
    function observable(data: any): kendo.data.ObservableObject;
    function observableHierarchy(array: any[]): kendo.data.ObservableArray;
    function parseDate(value: any, format?: string, culture?: string): Date;
    function parseFloat(value: any, culture?: string): number;
    function parseInt(value: any, culture?: string): number;
    function render(template:(data: any) => string, data: any[]): string;
    function resize(selector: string): void;
    function resize(element: JQuery): void;
    function resize(element: Element): void;
    function stringify(value: Object): string;
    function template(template: string, options?: TemplateOptions): (data: any) => string;
    function touchScroller(selector: string): void;
    function touchScroller(element: Element): void;
    function touchScroller(element: JQuery): void;
    function toString(value: number, format: string): string;
    function toString(value: Date, format: string): string;
    function unbind(selector: string): void;
    function unbind(element: JQuery): void;
    function unbind(element: Element): void;
    function guid(): string;
    function widgetInstance(element: JQuery, suite: typeof kendo.ui): kendo.ui.Widget;
    function widgetInstance(element: JQuery, suite: typeof kendo.mobile.ui): kendo.ui.Widget;


    var ns: string;

    var keys: {
        INSERT: number;
        DELETE: number;
        BACKSPACE: number;
        TAB: number;
        ENTER: number;
        ESC: number;
        LEFT: number;
        UP: number;
        RIGHT: number;
        DOWN: number;
        END: number;
        HOME: number;
        SPACEBAR: number;
        PAGEUP: number;
        PAGEDOWN: number;
        F2: number;
        F10: number;
        F12: number;
    }

    var support: {
        touch: boolean;
        pointers: boolean;
        scrollbar(): number;
        hasHW3D: boolean;
        hasNativeScrolling: boolean;
        devicePixelRatio: number;
        placeHolder: boolean;
        zoomLevel: number;
        mobileOS: {
            device: string;
            tablet: any;
            browser: string;
            name: string;
            majorVersion: string;
            minorVersion: string;
            flatVersion: number;
            appMode: boolean;
        };
        browser: {
            msie: boolean;
            webkit: boolean;
            safari: boolean;
            opera: boolean;
            version: string;
        };
    }

    interface TemplateOptions {
        paramName?: string;
        useWithBlock?: boolean;
    }

    class Class {
        static fn: Class;
        static extend(prototype: Object): Class;
    }

    class Observable extends Class {
        static fn: Observable;
        static extend(prototype: Object): Observable;

        bind(eventName: string, handler: Function): Observable;
        one(eventName: string, handler: Function): Observable;
        trigger(eventName: string, e?: any): boolean;
        unbind(eventName: string, handler?: any): Observable;
    }

    interface ViewOptions {
        tagName?: string;
        wrap?: boolean;
        model?: Object;
        init?: (e: ViewEvent) => void;
        show?: (e: ViewEvent) => void;
        hide?: (e: ViewEvent) => void;
    }

    interface ViewEvent {
        sender: View;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    class View extends Observable {
        constructor(element: Element, options?: ViewOptions);
        constructor(element: string, options?: ViewOptions);
        init(element: Element, options?: ViewOptions): void;
        init(element: string, options?: ViewOptions): void;
        render(container?: any): JQuery;
        destroy(): void;
        element: JQuery;
        content: any;
        tagName: string;
        model: Object;
    }

    class Layout extends View {
        showIn(selector: string, view: View): void;
        regions: { [selector: string]: View; };
    }

    class History extends Observable {
        start(options: Object): void;
        stop(): void;
        current: string;
        root: string;
        change(callback: Function): void;
        navigate(location: string, silent?: boolean): void;
    }

    var history: History;

    interface RouterOptions {
        init?: (e: RouterEvent) => void;
        routeMissing?: (e: RouterEvent) => void;
        change?: (e: RouterEvent) => void;
    }

    interface RouterEvent {
        sender: Router;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
        url: string;
    }

    class Route extends Class {
        route: RegExp;
        callback(url: string): void;
        worksWith(url: string): void;
    }

    class Router extends Observable {
        constructor(options?: RouterOptions);
        init(options?: RouterOptions): void;
        start(): void;
        destroy(): void;
        route(route: string, callback: Function): void;
        navigate(location: string, silent?: boolean): void;
        routes: Route[];
    }

}

declare module kendo.effects {
    interface Element {
        expand(direction: string): effects.Expand;
        expandHorizontal(): effects.Expand;
        expandVertical(): effects.Expand;
        fade(direction: string): effects.Fade;
        fadeIn(): effects.Fade;
        fadeOut(): effects.Fade;
        flip(axis: string, face: JQuery, back: JQuery): effects.Flip;
        flipHorizontal(face: JQuery, back: JQuery): effects.Flip;
        flipVertical(face: JQuery, back: JQuery): effects.Flip;
        pageturn(axis: string, face: JQuery, back: JQuery): effects.PageTurn;
        pageturnHorizontal(face: JQuery, back: JQuery): effects.PageTurn;
        pageturnVertical(face: JQuery, back: JQuery): effects.PageTurn;
        slideIn(direction: string): effects.SlideIn;
        slideInDown(): effects.SlideIn;
        slideInLeft(): effects.SlideIn;
        slideInRight(): effects.SlideIn;
        slideInUp(): effects.SlideIn;
        tile(direction: string, previous: JQuery): effects.Tile;
        tileDown(previous: JQuery): effects.Tile;
        tileLeft(previous: JQuery): effects.Tile;
        tileRight(previous: JQuery): effects.Tile;
        tileUp(previous: JQuery): effects.Tile;
        transfer(target: JQuery): effects.Transfer;
        zoom(direction: string): effects.Zoom;
        zoomIn(): effects.Zoom;
        zoomOut(): effects.Zoom;
    }

    interface Effect {
        play(): JQueryPromise<any>;
        reverse(): JQueryPromise<any>;
        duration(value: number): Effect;
        add(effect: Effect): Effect;
        stop(): Effect;
    }

    interface Expand extends Effect {
        duration(value: number): Expand;
        direction(value: string): Expand;
        stop(): Expand;
        add(effect: Effect): Expand;
    }

    interface Fade extends Effect {
        duration(value: number): Fade;
        direction(value: string): Fade;
        stop(): Fade;
        add(effect: Effect): Fade;
        startValue(value: number): Fade;
        endValue(value: number): Fade;
    }

    interface Flip extends Effect {
        duration(value: number): Flip;
        direction(value: string): Flip;
        stop(): Flip;
        add(effect: Effect): Flip;
    }

    interface PageTurn extends Effect {
        duration(value: number): PageTurn;
        direction(value: string): PageTurn;
        stop(): PageTurn;
        add(effect: Effect): PageTurn;
    }

    interface SlideIn extends Effect {
        duration(value: number): SlideIn;
        direction(value: string): SlideIn;
        stop(): SlideIn;
        add(effect: Effect): SlideIn;
    }

    interface Tile extends Effect {
        duration(value: number): Tile;
        direction(value: string): Tile;
        stop(): Tile;
        add(effect: Effect): Tile;
    }

    interface Transfer extends Effect {
        duration(value: number): Transfer;
        stop(): Transfer;
        add(effect: Effect): Transfer;
    }

    interface Zoom extends Effect {
        duration(value: number): Zoom;
        direction(value: string): Zoom;
        stop(): Zoom;
        add(effect: Effect): Zoom;
        startValue(value: number): Zoom;
        endValue(value: number): Zoom;
    }
}

declare module kendo.data {
    interface ObservableObjectEvent {
        sender?: ObservableObject;
        field?: string;
    }

    interface ObservableObjectSetEvent extends ObservableObjectEvent {
        value?: any;
        preventDefault?: Function;
    }


    class Binding extends Observable {
        source: any;
        parents: any[];
        path: string;
        dependencies: { [path: string]: boolean; };
        observable: boolean;
        constructor(parents: any[], path: string);
        change(e: Object): void;
        start(source: kendo.Observable): void;
        stop(source: kendo.Observable): void;
        get (): any;
        set (value: any): void;
        destroy(): void;
    }

    class EventBinding extends Binding {
        get (): void;
    }

    class TemplateBinding extends Binding {
        constructor(source: kendo.Observable, path: string, template: Function);
        render(value: Object): string;
    }

    module binders { }

    interface Bindings {
        [key: string]: Binding;
    }

    class Binder extends Class {
        static fn: Binder;
        static extend(prototype: Object): Binder;

        element: any;
        bindings: Bindings;
        constructor(element: any, bindings: Bindings, options?: BinderOptions);
        init(element: any, bindings: Bindings, options?: BinderOptions): void;
        bind(binding: Binding, attribute: string): void;
        destroy(): void;
        refresh(): void;
        refresh(attribute: string): void;
        options: BinderOptions;
    }

    interface BinderOptions {
    }

    class ObservableObject extends Observable{
        constructor(value?: any);
        init(value?: any): void;
        get(name: string): any;
        parent(): ObservableObject;
        set(name: string, value: any): void;
        toJSON(): Object;
        uid: string;
    }

    class Model extends ObservableObject {
        idField: string;
        _defaultId: any;
        fields: DataSourceSchemaModelFields;
        defaults: {
            [field: string]: any;
        };
        constructor(data?: any);
        init(data?: any):void;
        dirty: boolean;
        id: any;
        editable(field: string): boolean;
        isNew(): boolean;
        static idField: string;
        static fields: DataSourceSchemaModelFields;
        static define(options: DataSourceSchemaModelWithFieldsObject): typeof Model;
        static define(options: DataSourceSchemaModelWithFieldsArray): typeof Model;
    }

    class SchedulerEvent extends Model {
        constructor(data?: any);
        init(data?: any): void;

        description: string;
        end: Date;
        endTimezone: string;
        isAllDay: boolean;
        id: any;
        start: Date;
        startTimezone: string;
        recurrenceId: any;
        recurrenceRule: string;
        recurrenceException: string;
        static idField: string;
        static fields: DataSourceSchemaModelFields;
        static define(options: DataSourceSchemaModelWithFieldsObject): typeof SchedulerEvent;
        static define(options: DataSourceSchemaModelWithFieldsArray): typeof SchedulerEvent;
    }

    class Node extends Model {
        children: HierarchicalDataSource;

        append(model: any): void;
        level(): number;
        load(id: any): void;
        loaded(value: boolean): void;
        loaded(): boolean;
        parentNode(): Node;
    }

    class SchedulerDataSource extends DataSource {
        add(model: Object): kendo.data.SchedulerEvent;
        add(model: kendo.data.SchedulerEvent): kendo.data.SchedulerEvent;
        at(index: number): kendo.data.SchedulerEvent;
        cancelChanges(model?: kendo.data.SchedulerEvent): void;
        get(id: any): kendo.data.SchedulerEvent;
        getByUid(uid: string): kendo.data.SchedulerEvent;
        indexOf(value: kendo.data.SchedulerEvent): number;
        insert(index: number, model: kendo.data.SchedulerEvent): kendo.data.SchedulerEvent;
        insert(index: number, model: Object): kendo.data.SchedulerEvent;
        remove(model: kendo.data.SchedulerEvent): void;
    }

    class HierarchicalDataSource extends DataSource {
        constructor(options?: HierarchicalDataSourceOptions);
        init(options?: HierarchicalDataSourceOptions): void;
    }

    interface HierarchicalDataSourceOptions extends DataSourceOptions {
        schema?: HierarchicalDataSourceSchema;
    }


    interface HierarchicalDataSourceSchema extends DataSourceSchemaWithOptionsModel {
        model?: HierarchicalDataSourceSchemaModel;
    }

    interface HierarchicalDataSourceSchemaModel extends DataSourceSchemaModel {
        hasChildren?: any;
        children?: any;
    }

    interface DataSourceTransport {
        parameterMap?(data: DataSourceTransportParameterMapData, type: string): any;
    }

    interface DataSourceParameterMapDataAggregate {
        field?: string;
        aggregate?: string;
    }

    interface DataSourceParameterMapDataGroup {
        aggregate?: DataSourceParameterMapDataAggregate[];
        field?: string;
        dir?: string;
    }

    interface DataSourceParameterMapDataFilter {
        field?: string;
        filters?: DataSourceParameterMapDataFilter[];
        logic?: string;
        operator?: string;
        value?: any;
    }

    interface DataSourceParameterMapDataSort {
        field?: string;
        dir?: string;
    }

    interface DataSourceTransportParameterMapData {
        aggregate?: DataSourceParameterMapDataAggregate[];
        group?: DataSourceParameterMapDataGroup[];
        filter?: DataSourceParameterMapDataFilter;
        models?: Model[];
        page?: number;
        pageSize?: number;
        skip?: number;
        sort?: DataSourceParameterMapDataSort[];
        take?: number;
    }

    interface DataSourceSchema {
        model?: any;
    }

    interface DataSourceSchemaWithOptionsModel extends DataSourceSchema {
        model?: DataSourceSchemaModel;
    }

    interface DataSourceSchemaWithConstructorModel extends DataSourceSchema {
        model?:  typeof Model;
    }

    interface DataSourceSchemaModel {
        id?: string;
        fields?: any;
    }

    interface DataSourceSchemaModelWithFieldsArray extends DataSourceSchemaModel {
        fields?: DataSourceSchemaModelField[];
    }

    interface DataSourceSchemaModelWithFieldsObject extends DataSourceSchemaModel {
        fields?: DataSourceSchemaModelFields;
    }

    interface DataSourceSchemaModelFields {
        [index: string]: DataSourceSchemaModelField;
    }

    interface DataSourceSchemaModelField {
        field?: string;
        from?: string;
        defaultValue?: any;
        editable?: boolean;
        nullable?: boolean;
        parse?: Function;
        type?: string;
        validation?: DataSourceSchemaModelFieldValidation;
    }

    interface DataSourceSchemaModelFieldValidation {
        required?: boolean;
        min?: any;
        max?: any;
    }

    class ObservableArray extends Observable {
        constructor(array?: any[]);
        init(array?: any[]): void;
        length: number;
        join(separator: string): string;
        parent(): ObservableObject;
        pop(): ObservableObject;
        push(...items: any[]): number;
        slice(begin: number, end?: number): any[];
        splice(start: number): any[];
        splice(start: number, deleteCount: number, ...items: any[]): any[];
        shift(): any;
        toJSON(): any[];
        unshift(...items: any[]): number;
        wrapAll(source: Object, target: Object): any;
        wrap(object: Object, parent: Object): any;
        indexOf(item: any): number;
        forEach(callback: (item: Object, index: number, source: ObservableArray) => void ): void;
        map(callback: (item: Object, index: number, source: ObservableArray) => any): any[];
        filter(callback: (item: Object, index: number, source: ObservableArray) => boolean): any[];
        find(callback: (item: Object, index: number, source: ObservableArray) => boolean): any;
        every(callback: (item: Object, index: number, source: ObservableArray) => boolean): boolean;
        some(callback: (item: Object, index: number, source: ObservableArray) => boolean): boolean;
        remove(item: Object): void;
    }

    interface ObservableArrayEvent {
        field?: string;
        action?: string;
        index?: number;
        items?: kendo.data.Model[];
    }

    class DataSource extends Observable{
        constructor(options?: DataSourceOptions);
        init(options?: DataSourceOptions): void;
        static create(options?: DataSourceOptions): DataSource;
        options: DataSourceOptions;
        add(model: Object): kendo.data.Model;
        add(model: kendo.data.Model): kendo.data.Model;
        aggregate(val?: any): any;
        aggregates(): any;
        at(index: number): kendo.data.ObservableObject;
        cancelChanges(model?: kendo.data.Model): void;
        data(): kendo.data.ObservableArray;
        data(value: any): void;
        fetch(callback?: Function): void;
        filter(filters: DataSourceFilterItem): void;
        filter(filters: DataSourceFilterItem[]): void;
        filter(filters: DataSourceFilters): void;
        filter(): DataSourceFilters;
        get(id: any): kendo.data.Model;
        getByUid(uid: string): kendo.data.Model;
        group(groups: any): void;
        group(): any;
        hasChanges(): boolean;
        indexOf(value: kendo.data.ObservableObject): number;
        insert(index: number, model: kendo.data.Model): kendo.data.Model;
        insert(index: number, model: Object): kendo.data.Model;
        page(): number;
        page(page: number): void;
        pageSize(): number;
        pageSize(size: number): void;
        query(options?: any): void;
        read(data?: any): void;
        remove(model: kendo.data.Model): void;
        sort(sort: DataSourceSortItem): void;
        sort(sort: DataSourceSortItem[]): void;
        sort(): DataSourceSortItem[];
        sync(): void;
        total(): number;
        totalPages(): number;
        view(): kendo.data.ObservableArray;
    }

    interface DataSourceAggregateItem {
        field?: string;
        aggregate?: string;
    }

    interface DataSourceFilter {
    }

    interface DataSourceFilterItem extends DataSourceFilter {
        operator?: string;
        field?: string;
        value?: any;
    }

    interface DataSourceFilters extends DataSourceFilter {
        logic?: string;
        filters?: DataSourceFilter[];
    }

    interface DataSourceGroupItemAggregate {
        field?: string;
        aggregate?: string;
    }

    interface DataSourceGroupItem {
        field?: string;
        dir?: string;
        aggregates?: DataSourceGroupItemAggregate[];
    }

    interface DataSourceSchema {
        aggregates?: any;
        data?: any;
        errors?: any;
        groups?: any;
        parse?: Function;
        total?: any;
        type?: string;
    }

    interface DataSourceSortItem {
        field?: string;
        dir?: string;
    }

    interface DataSourceTransportCreate {
        cache?: boolean;
        contentType?: string;
        data?: any;
        dataType?: string;
        type?: string;
        url?: any;
    }

    interface DataSourceTransportDestroy {
        cache?: boolean;
        contentType?: string;
        data?: any;
        dataType?: string;
        type?: string;
        url?: any;
    }

    interface DataSourceTransportRead {
        cache?: boolean;
        contentType?: string;
        data?: any;
        dataType?: string;
        type?: string;
        url?: any;
    }

    interface DataSourceTransportUpdate {
        cache?: boolean;
        contentType?: string;
        data?: any;
        dataType?: string;
        type?: string;
        url?: any;
    }

    interface DataSourceTransport {
        create?: any;
        destroy?: any;
        read?: any;
        update?: any;
    }

    interface DataSourceTransportWithObjectOperations extends DataSourceTransport {
        create?: DataSourceTransportCreate;
        destroy?: DataSourceTransportDestroy;
        read?: DataSourceTransportRead;
        update?: DataSourceTransportUpdate;
    }

    interface DataSourceTransportWithFunctionOperations extends DataSourceTransport {
        create?: (options: DataSourceTransportOptions) => void;
        destroy?: (options: DataSourceTransportOptions) => void;
        read?: (options: DataSourceTransportReadOptions) => void;
        update?: (options: DataSourceTransportOptions) => void;
    }

    interface DataSourceTransportOptions {
        success: (data?: any) => void;
        error: (error?: any) => void;
        data: any;
    }

    interface DataSourceTransportReadOptionsData {
        sort?: DataSourceSortItem[];
        filter?: DataSourceFilters;
        take?: number;
        skip?: number;
    }

    interface DataSourceTransportReadOptions extends DataSourceTransportOptions {
        data: DataSourceTransportReadOptionsData;
    }

    interface DataSourceTransportBatchOptionsData {
        models: any[];
    }

    interface DataSourceTransportBatchOptions extends DataSourceTransportOptions {
        data: DataSourceTransportBatchOptionsData;
    }

    interface DataSourceOptions {
        aggregate?: DataSourceAggregateItem[];
        autoSync?: boolean;
        batch?: boolean;
        data?: any;
        filter?: any;
        group?: DataSourceGroupItem[];
        page?: number;
        pageSize?: number;
        schema?: DataSourceSchema;
        serverAggregates?: boolean;
        serverFiltering?: boolean;
        serverGrouping?: boolean;
        serverPaging?: boolean;
        serverSorting?: boolean;
        sort?: any;
        transport?: DataSourceTransport;
        type?: string;
        change? (e: DataSourceChangeEvent): void;
        error?(e: DataSourceErrorEvent): void;
        sync?(e: DataSourceEvent): void;
        requestStart?(e: DataSourceRequestStartEvent): void;
        requestEnd?(e: DataSourceRequestEndEvent): void;
    }

    interface DataSourceEvent {
        sender?: DataSource;
    }

    interface DataSourceItemOrGroup {
    }

    interface DataSourceGroup extends DataSourceItemOrGroup {
        aggregates: any[];
        field: string;
        hasSubgroups: boolean;
        items: DataSourceItemOrGroup[];
        value: any;
    }

    interface DataSourceChangeEvent extends DataSourceEvent {
        field?: string;
        value?: Model;
        action?: string;
        index?: number;
        items?: DataSourceItemOrGroup[];
        node?: any;
    }

    interface DataSourceErrorEvent extends DataSourceEvent {
        xhr: JQueryXHR;
        status: string;
        errorThrown: any;
        errors?: any;
    }

    interface DataSourceRequestStartEvent extends DataSourceEvent {
    }

    interface DataSourceRequestEndEvent extends DataSourceEvent {
        response?: any;
        type?: string;
    }
}

declare module kendo.data.transports {
    var odata : DataSourceTransport;
}

declare module kendo.ui {
    function progress(container: JQuery, toggle: boolean): void;

    class Widget extends Observable {
        static fn: Widget;
        static extend(prototype: Object): Widget;

        constructor(element: Element, options?: Object);
        constructor(element: JQuery, options?: Object);
        constructor(selector: String, options?: Object);
        init(element: Element, options?: Object): void;
        init(element: JQuery, options?: Object): void;
        init(selector: String, options?: Object): void;
        destroy(): void;
        element: JQuery;
        setOptions(options: Object): void;
        resize(force?: boolean): void;
    }

    function plugin(widget: typeof kendo.ui.Widget, register?: typeof kendo.ui, prefix?: String): void;
    function plugin(widget: any, register?: typeof kendo.ui, prefix?: String): void;
    function plugin(widget: typeof kendo.ui.Widget, register?: typeof kendo.mobile.ui, prefix?: String): void;
    function plugin(widget: any, register?: typeof kendo.mobile.ui, prefix?: String): void;

    class Draggable extends kendo.ui.Widget{
        element: JQuery;
        currentTarget: JQuery;
        constructor(element: Element, options?: DraggableOptions);
        options: DraggableOptions;
    }

    interface DraggableEvent extends JQueryEventObject {
        sender?: Draggable;
    }

    class DropTarget extends kendo.ui.Widget{
        element: JQuery;
        constructor(element: Element, options?: DropTargetOptions);
        options: DropTargetOptions;
        static destroyGroup(groupName: string): void;
    }

    interface DropTargetOptions {
        group?: string;
        dragenter?(e: DropTargetDragenterEvent): void;
        dragleave?(e: DropTargetDragleaveEvent): void;
        drop?(e: DropTargetDropEvent): void;
    }

    interface DropTargetEvent extends JQueryEventObject {
        sender?: DropTarget;
    }

    interface DropTargetDragenterEvent extends DropTargetEvent {
        draggable?: kendo.ui.Draggable;
    }

    interface DropTargetDragleaveEvent extends DropTargetEvent {
        draggable?: kendo.ui.Draggable;
    }

    interface DropTargetDropEvent extends DropTargetEvent {
        draggable?: kendo.ui.Draggable;
    }

    class DropTargetArea extends kendo.ui.Widget{
        element: JQuery;
        constructor(element: Element, options?: DropTargetAreaOptions);
        options: DropTargetAreaOptions;
    }

    interface DropTargetAreaOptions {
        group?: string;
        filter?: string;
        dragenter?(e: DropTargetAreaDragenterEvent): void;
        dragleave?(e: DropTargetAreaDragleaveEvent): void;
        drop?(e: DropTargetAreaDropEvent): void;
    }

    interface DropTargetAreaEvent extends JQueryEventObject {
        sender: DropTargetArea;
    }

    interface DropTargetAreaDragenterEvent extends DropTargetAreaEvent {
        draggable?: JQuery;
    }

    interface DropTargetAreaDragleaveEvent extends DropTargetAreaEvent {
        draggable?: JQuery;
    }

    interface DropTargetAreaDropEvent extends DropTargetAreaEvent {
        draggable?: kendo.ui.Draggable;
        dropTarget?: JQuery;
    }

    interface DraggableOptions {
        axis?: string;
        cursorOffset?: any;
        distance?: number;
        group?: string;
        hint?: Function;
        drag?(e: DraggableEvent): void;
        dragcancel?(e: DraggableEvent): void;
        dragend?(e: DraggableEvent): void;
        dragstart?(e: DraggableEvent): void;
    }

    interface GridColumnEditorOptions {
        field?: string;
        format?: string;
        model?: kendo.data.Model;
        values?: any[];
    }

    interface GridColumn {
        editor?(container: JQuery, options: GridColumnEditorOptions): void;
    }
}

declare module kendo.mobile {
    function init(selector: string): void;
    function init(element: JQuery): void;
    function init(element: Element): void;

    class Application extends Observable {
        constructor(element?: any, options?: ApplicationOptions);
        init(element?: any, options?: ApplicationOptions): void;
        options: ApplicationOptions;
        hideLoading(): void;
        navigate(url: string, transition?: string): void;
        scroller(): kendo.mobile.ui.Scroller;
        showLoading(): void;
        view(): kendo.mobile.ui.View;
    }

    interface ApplicationOptions {
        hideAddressBar?: boolean;
        updateDocumentTitle?: boolean;
        initial?: string;
        layout?: string;
        loading?: string;
        platform?: string;
        serverNavigation?: boolean;
        transition?: string;
    }

    interface ApplicationEvent {
        sender: Application;
    }
}

declare module kendo.mobile.ui {

    class Widget extends kendo.ui.Widget {
    }

    interface TouchAxis {
        location?: number;
        startLocation?: number;
        client?: number;
        delta?: number;
        velocity?: number;
    }

    interface TouchEventOptions {
        target?: JQuery;
        x?: TouchAxis;
        y?: TouchAxis;
    }

    interface Point {
        x?: number;
        y?: number;
    }
}
declare module kendo {
    class Color extends Observable {
        options: ColorOptions;
        diff(): number;
        equals(): boolean;
    }

    interface ColorOptions {
        name?: string;
    }

    interface ColorEvent {
        sender: Color;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }


}
declare module FX {
    class FX  {
        options: FXOptions;
        kendoAnimate(duration: number, reverse: boolean, complete: Function, show: boolean, hide: boolean): void;
        kendoStop(gotoEnd: boolean): void;
        kendoAddClass(classes: string, options: any): void;
        kendoRemoveClass(classes: string, options: any): void;
        kendoToggleClass(classes: string, options: any, toggle: boolean): void;
    }

    interface FXKendoAddClassOptions {
        duration?: number;
        exclusive?: string;
        ease?: string;
    }

    interface FXKendoRemoveClassOptions {
        duration?: number;
        exclusive?: string;
        ease?: string;
    }

    interface FXKendoToggleClassOptions {
        duration?: number;
        exclusive?: string;
        ease?: string;
    }

    interface FXOptions {
        name?: string;
    }

    interface FXEvent {
        sender: FX;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }


}
declare module kendo.mobile.ui {
    class ActionSheet extends kendo.mobile.ui.Widget {
        static fn: ActionSheet;
        static extend(proto: Object): ActionSheet;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: ActionSheetOptions);
        options: ActionSheetOptions;
        close(): void;
        destroy(): void;
        open(target: JQuery, context: any): void;
    }

    interface ActionSheetPopup {
        direction?: any;
        height?: any;
        width?: any;
    }

    interface ActionSheetOptions {
        name?: string;
        cancel?: string;
        popup?: ActionSheetPopup;
        type?: string;
        close?(e: ActionSheetEvent): void;
        open?(e: ActionSheetOpenEvent): void;
    }

    interface ActionSheetEvent {
        sender: ActionSheet;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface ActionSheetOpenEvent extends ActionSheetEvent {
        target?: JQuery;
        context?: JQuery;
    }


    class BackButton extends kendo.mobile.ui.Widget {
        static fn: BackButton;
        static extend(proto: Object): BackButton;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: BackButtonOptions);
        options: BackButtonOptions;
        destroy(): void;
    }

    interface BackButtonOptions {
        name?: string;
        click?(e: BackButtonClickEvent): void;
    }

    interface BackButtonEvent {
        sender: BackButton;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface BackButtonClickEvent extends BackButtonEvent {
        target?: JQuery;
        button?: JQuery;
    }


    class Button extends kendo.mobile.ui.Widget {
        static fn: Button;
        static extend(proto: Object): Button;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: ButtonOptions);
        options: ButtonOptions;
        badge(value: string): string;
        badge(value: boolean): string;
        destroy(): void;
        enable(enable: boolean): void;
    }

    interface ButtonOptions {
        name?: string;
        badge?: string;
        enable?: boolean;
        icon?: string;
        click?(e: ButtonClickEvent): void;
    }

    interface ButtonEvent {
        sender: Button;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface ButtonClickEvent extends ButtonEvent {
        target?: JQuery;
        button?: JQuery;
    }


    class ButtonGroup extends kendo.mobile.ui.Widget {
        static fn: ButtonGroup;
        static extend(proto: Object): ButtonGroup;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: ButtonGroupOptions);
        options: ButtonGroupOptions;
        badge(button: string, value: string): string;
        badge(button: string, value: boolean): string;
        badge(button: number, value: string): string;
        badge(button: number, value: boolean): string;
        current(): JQuery;
        destroy(): void;
        select(li: JQuery): void;
        select(li: number): void;
    }

    interface ButtonGroupOptions {
        name?: string;
        index?: number;
        selectOn?: string;
        select?(e: ButtonGroupSelectEvent): void;
    }

    interface ButtonGroupEvent {
        sender: ButtonGroup;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface ButtonGroupSelectEvent extends ButtonGroupEvent {
        index?: number;
    }


    class DetailButton extends kendo.mobile.ui.Widget {
        static fn: DetailButton;
        static extend(proto: Object): DetailButton;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: DetailButtonOptions);
        options: DetailButtonOptions;
        destroy(): void;
    }

    interface DetailButtonOptions {
        name?: string;
        click?(e: DetailButtonClickEvent): void;
    }

    interface DetailButtonEvent {
        sender: DetailButton;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface DetailButtonClickEvent extends DetailButtonEvent {
        target?: JQuery;
        button?: JQuery;
    }


    class Drawer extends kendo.mobile.ui.Widget {
        static fn: Drawer;
        static extend(proto: Object): Drawer;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: DrawerOptions);
        options: DrawerOptions;
        destroy(): void;
        hide(): void;
        show(): void;
    }

    interface DrawerOptions {
        name?: string;
        position?: string;
        swipeToOpen?: boolean;
        title?: string;
        views?: any;
        beforeShow?(e: DrawerEvent): void;
        hide?(e: DrawerHideEvent): void;
        init?(e: DrawerInitEvent): void;
        show?(e: DrawerShowEvent): void;
    }

    interface DrawerEvent {
        sender: Drawer;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface DrawerHideEvent extends DrawerEvent {
    }

    interface DrawerInitEvent extends DrawerEvent {
    }

    interface DrawerShowEvent extends DrawerEvent {
    }


    class Layout extends kendo.mobile.ui.Widget {
        static fn: Layout;
        static extend(proto: Object): Layout;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: LayoutOptions);
        options: LayoutOptions;
    }

    interface LayoutOptions {
        name?: string;
        id?: string;
        platform?: string;
        hide?(e: LayoutHideEvent): void;
        init?(e: LayoutInitEvent): void;
        show?(e: LayoutShowEvent): void;
    }

    interface LayoutEvent {
        sender: Layout;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface LayoutHideEvent extends LayoutEvent {
        layout?: JQuery;
        view?: JQuery;
    }

    interface LayoutInitEvent extends LayoutEvent {
        layout?: JQuery;
    }

    interface LayoutShowEvent extends LayoutEvent {
        layout?: JQuery;
        view?: JQuery;
    }


    class ListView extends kendo.mobile.ui.Widget {
        static fn: ListView;
        static extend(proto: Object): ListView;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: ListViewOptions);
        options: ListViewOptions;
        dataSource: kendo.data.DataSource;
        append(dataItems: any): void;
        prepend(dataItems: any): void;
        replace(dataItems: any): void;
        remove(dataItems: any): void;
        setDataItem(item: JQuery, dataItem: kendo.data.Model): void;
        destroy(): void;
        items(): JQuery;
        refresh(): void;
        setDataSource(dataSource: kendo.data.DataSource): void;
    }

    interface ListViewFilterable {
        placeholder?: string;
        autoFilter?: boolean;
        field?: string;
        ignoreCase?: boolean;
        operator?: string;
    }

    interface ListViewOptions {
        name?: string;
        appendOnRefresh?: boolean;
        autoBind?: boolean;
        dataSource?: any;
        endlessScroll?: boolean;
        fixedHeaders?: boolean;
        headerTemplate?: any;
        loadMore?: boolean;
        loadMoreText?: string;
        pullToRefresh?: boolean;
        pullParameters?: Function;
        style?: string;
        template?: any;
        type?: string;
        filterable?: ListViewFilterable;
        click?(e: ListViewClickEvent): void;
        dataBound?(e: ListViewEvent): void;
        dataBinding?(e: ListViewEvent): void;
        itemChange?(e: ListViewEvent): void;
    }

    interface ListViewEvent {
        sender: ListView;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface ListViewClickEvent extends ListViewEvent {
        item?: JQuery;
        target?: JQuery;
        dataItem?: any;
        button?: kendo.mobile.ui.Button;
    }


    class Loader extends kendo.mobile.ui.Widget {
        static fn: Loader;
        static extend(proto: Object): Loader;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: LoaderOptions);
        options: LoaderOptions;
        hide(): void;
        show(): void;
    }

    interface LoaderOptions {
        name?: string;
    }

    interface LoaderEvent {
        sender: Loader;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }


    class ModalView extends kendo.mobile.ui.Widget {
        static fn: ModalView;
        static extend(proto: Object): ModalView;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: ModalViewOptions);
        options: ModalViewOptions;
        close(): void;
        destroy(): void;
        open(target: JQuery): void;
    }

    interface ModalViewOptions {
        name?: string;
        height?: number;
        modal?: boolean;
        width?: number;
        close?(e: ModalViewCloseEvent): void;
        init?(e: ModalViewInitEvent): void;
        open?(e: ModalViewOpenEvent): void;
    }

    interface ModalViewEvent {
        sender: ModalView;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface ModalViewCloseEvent extends ModalViewEvent {
    }

    interface ModalViewInitEvent extends ModalViewEvent {
    }

    interface ModalViewOpenEvent extends ModalViewEvent {
        target?: JQuery;
    }


    class NavBar extends kendo.mobile.ui.Widget {
        static fn: NavBar;
        static extend(proto: Object): NavBar;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: NavBarOptions);
        options: NavBarOptions;
        destroy(): void;
        title(value: string): void;
    }

    interface NavBarOptions {
        name?: string;
    }

    interface NavBarEvent {
        sender: NavBar;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }


    class Pane extends kendo.mobile.ui.Widget {
        static fn: Pane;
        static extend(proto: Object): Pane;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: PaneOptions);
        options: PaneOptions;
        destroy(): void;
        hideLoading(): void;
        navigate(url: string, transition: string): void;
        replace(url: string, transition: string): void;
        Example(): void;
        showLoading(): void;
        view(): kendo.mobile.ui.View;
    }

    interface PaneOptions {
        name?: string;
        collapsible?: boolean;
        initial?: string;
        layout?: string;
        loading?: string;
        portraitWidth?: number;
        transition?: string;
        navigate?(e: PaneNavigateEvent): void;
        viewShow?(e: PaneViewShowEvent): void;
    }

    interface PaneEvent {
        sender: Pane;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface PaneNavigateEvent extends PaneEvent {
        url?: JQuery;
    }

    interface PaneViewShowEvent extends PaneEvent {
        view?: kendo.mobile.ui.View;
    }


    class PopOver extends kendo.mobile.ui.Widget {
        static fn: PopOver;
        static extend(proto: Object): PopOver;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: PopOverOptions);
        options: PopOverOptions;
        close(): void;
        destroy(): void;
        open(target: JQuery): void;
    }

    interface PopOverPane {
        initial?: string;
        layout?: string;
        loading?: string;
        transition?: string;
    }

    interface PopOverPopup {
        height?: any;
        width?: any;
    }

    interface PopOverOptions {
        name?: string;
        pane?: PopOverPane;
        popup?: PopOverPopup;
        close?(e: PopOverCloseEvent): void;
        open?(e: PopOverOpenEvent): void;
    }

    interface PopOverEvent {
        sender: PopOver;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface PopOverCloseEvent extends PopOverEvent {
    }

    interface PopOverOpenEvent extends PopOverEvent {
        target?: JQuery;
    }


    class ScrollView extends kendo.mobile.ui.Widget {
        static fn: ScrollView;
        static extend(proto: Object): ScrollView;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: ScrollViewOptions);
        options: ScrollViewOptions;
        dataSource: kendo.data.DataSource;
        content(content: string): void;
        content(content: JQuery): void;
        destroy(): void;
        next(): void;
        prev(): void;
        refresh(): void;
        scrollTo(page: number, instant: boolean): void;
        setDataSource(dataSource: kendo.data.DataSource): void;
    }

    interface ScrollViewOptions {
        name?: string;
        autoBind?: boolean;
        bounceVelocityThreshold?: number;
        contentHeight?: any;
        dataSource?: any;
        duration?: number;
        emptyTemplate?: string;
        enablePager?: boolean;
        itemsPerPage?: number;
        page?: number;
        pageSize?: number;
        template?: string;
        velocityThreshold?: number;
        changing?(e: ScrollViewChangingEvent): void;
        change?(e: ScrollViewChangeEvent): void;
        refresh?(e: ScrollViewRefreshEvent): void;
    }

    interface ScrollViewEvent {
        sender: ScrollView;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface ScrollViewChangingEvent extends ScrollViewEvent {
        currentPage?: number;
        nextPage?: number;
    }

    interface ScrollViewChangeEvent extends ScrollViewEvent {
        page?: number;
        element?: JQuery;
        data?: any;
    }

    interface ScrollViewRefreshEvent extends ScrollViewEvent {
        pageCount?: number;
        page?: number;
    }


    class Scroller extends kendo.mobile.ui.Widget {
        static fn: Scroller;
        static extend(proto: Object): Scroller;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: ScrollerOptions);
        options: ScrollerOptions;
        animatedScrollTo(x: number, y: number): void;
        destroy(): void;
        disable(): void;
        enable(): void;
        height(): number;
        pullHandled(): void;
        reset(): void;
        scrollHeight(): void;
        scrollTo(x: number, y: number): void;
        scrollWidth(): void;
        zoomOut(): void;
    }

    interface ScrollerOptions {
        name?: string;
        zoom?: boolean;
        elastic?: boolean;
        pullOffset?: number;
        pullTemplate?: string;
        pullToRefresh?: boolean;
        refreshTemplate?: string;
        releaseTemplate?: string;
        useNative?: boolean;
        pull?(e: ScrollerEvent): void;
        resize?(e: ScrollerEvent): void;
        scroll?(e: ScrollerScrollEvent): void;
    }

    interface ScrollerEvent {
        sender: Scroller;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface ScrollerScrollEvent extends ScrollerEvent {
        scrollTop?: number;
        scrollLeft?: number;
    }


    class SplitView extends kendo.mobile.ui.Widget {
        static fn: SplitView;
        static extend(proto: Object): SplitView;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: SplitViewOptions);
        options: SplitViewOptions;
        destroy(): void;
        expandPanes(): void;
        collapsePanes(): void;
    }

    interface SplitViewOptions {
        name?: string;
        style?: string;
        init?(e: SplitViewInitEvent): void;
        show?(e: SplitViewShowEvent): void;
    }

    interface SplitViewEvent {
        sender: SplitView;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface SplitViewInitEvent extends SplitViewEvent {
        view?: JQuery;
    }

    interface SplitViewShowEvent extends SplitViewEvent {
        view?: JQuery;
    }


    class Switch extends kendo.mobile.ui.Widget {
        static fn: Switch;
        static extend(proto: Object): Switch;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: SwitchOptions);
        options: SwitchOptions;
        check(): boolean;
        check(check: boolean): void;
        destroy(): void;
        enable(enable: boolean): void;
        refresh(): void;
        toggle(): void;
    }

    interface SwitchOptions {
        name?: string;
        checked?: boolean;
        enable?: boolean;
        offLabel?: string;
        onLabel?: string;
        change?(e: SwitchChangeEvent): void;
    }

    interface SwitchEvent {
        sender: Switch;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface SwitchChangeEvent extends SwitchEvent {
        checked?: any;
    }


    class TabStrip extends kendo.mobile.ui.Widget {
        static fn: TabStrip;
        static extend(proto: Object): TabStrip;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: TabStripOptions);
        options: TabStripOptions;
        badge(tab: string, value: string): string;
        badge(tab: string, value: boolean): string;
        badge(tab: number, value: string): string;
        badge(tab: number, value: boolean): string;
        currentItem(): JQuery;
        destroy(): void;
        switchTo(url: string): void;
        switchTo(url: number): void;
        switchByFullUrl(url: string): void;
        clear(): void;
    }

    interface TabStripOptions {
        name?: string;
        selectedIndex?: number;
        select?(e: TabStripSelectEvent): void;
    }

    interface TabStripEvent {
        sender: TabStrip;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface TabStripSelectEvent extends TabStripEvent {
        item?: JQuery;
    }


    class View extends kendo.mobile.ui.Widget {
        static fn: View;
        static extend(proto: Object): View;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: ViewOptions);
        options: ViewOptions;
        contentElement(): void;
        destroy(): void;
        enable(enable: boolean): void;
    }

    interface ViewOptions {
        name?: string;
        model?: string;
        reload?: boolean;
        stretch?: boolean;
        title?: string;
        useNativeScrolling?: boolean;
        zoom?: boolean;
        afterShow?(e: ViewAfterShowEvent): void;
        beforeHide?(e: ViewBeforeHideEvent): void;
        beforeShow?(e: ViewBeforeShowEvent): void;
        hide?(e: ViewHideEvent): void;
        init?(e: ViewInitEvent): void;
        show?(e: ViewShowEvent): void;
    }

    interface ViewEvent {
        sender: View;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface ViewAfterShowEvent extends ViewEvent {
        view?: kendo.mobile.ui.View;
    }

    interface ViewBeforeHideEvent extends ViewEvent {
        view?: kendo.mobile.ui.View;
    }

    interface ViewBeforeShowEvent extends ViewEvent {
        view?: kendo.mobile.ui.View;
    }

    interface ViewHideEvent extends ViewEvent {
        view?: kendo.mobile.ui.View;
    }

    interface ViewInitEvent extends ViewEvent {
        view?: kendo.mobile.ui.View;
    }

    interface ViewShowEvent extends ViewEvent {
        view?: kendo.mobile.ui.View;
    }


}
declare module kendo.ui {
    class Touch extends kendo.ui.Widget {
        static fn: Touch;
        static extend(proto: Object): Touch;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: TouchOptions);
        options: TouchOptions;
        cancel(): void;
        destroy(): void;
    }

    interface TouchOptions {
        name?: string;
        filter?: string;
        multiTouch?: boolean;
        enableSwipe?: boolean;
        minXDelta?: number;
        maxYDelta?: number;
        maxDuration?: number;
        minHold?: number;
        doubleTapTimeout?: number;
        touchstart?(e: TouchTouchstartEvent): void;
        dragstart?(e: TouchDragstartEvent): void;
        drag?(e: TouchDragEvent): void;
        dragend?(e: TouchDragendEvent): void;
        tap?(e: TouchTapEvent): void;
        doubletap?(e: TouchDoubletapEvent): void;
        hold?(e: TouchHoldEvent): void;
        swipe?(e: TouchSwipeEvent): void;
        gesturestart?(e: TouchGesturestartEvent): void;
        gesturechange?(e: TouchGesturechangeEvent): void;
        gestureend?(e: TouchGestureendEvent): void;
    }

    interface TouchEvent {
        sender: Touch;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface TouchTouchstartEvent extends TouchEvent {
        touch?: kendo.mobile.ui.TouchEventOptions;
        event?: JQueryEventObject;
    }

    interface TouchDragstartEvent extends TouchEvent {
        touch?: kendo.mobile.ui.TouchEventOptions;
        event?: JQueryEventObject;
    }

    interface TouchDragEvent extends TouchEvent {
        touch?: kendo.mobile.ui.TouchEventOptions;
        event?: JQueryEventObject;
    }

    interface TouchDragendEvent extends TouchEvent {
        touch?: kendo.mobile.ui.TouchEventOptions;
        event?: JQueryEventObject;
    }

    interface TouchTapEvent extends TouchEvent {
        touch?: kendo.mobile.ui.TouchEventOptions;
        event?: JQueryEventObject;
    }

    interface TouchDoubletapEvent extends TouchEvent {
        touch?: kendo.mobile.ui.TouchEventOptions;
        event?: JQueryEventObject;
    }

    interface TouchHoldEvent extends TouchEvent {
        touch?: kendo.mobile.ui.TouchEventOptions;
        event?: JQueryEventObject;
    }

    interface TouchSwipeEvent extends TouchEvent {
        touch?: kendo.mobile.ui.TouchEventOptions;
        event?: JQueryEventObject;
    }

    interface TouchGesturestartEvent extends TouchEvent {
        touches?: any;
        event?: JQueryEventObject;
        distance?: number;
        center?: kendo.mobile.ui.Point;
    }

    interface TouchGesturechangeEvent extends TouchEvent {
        touches?: any;
        event?: JQueryEventObject;
        distance?: number;
        center?: kendo.mobile.ui.Point;
    }

    interface TouchGestureendEvent extends TouchEvent {
        touches?: any;
        event?: JQueryEventObject;
        distance?: number;
        center?: kendo.mobile.ui.Point;
    }


    class Validator extends kendo.ui.Widget {
        static fn: Validator;
        static extend(proto: Object): Validator;

        element: JQuery;
        wrapper: JQuery;
        constructor(element: Element, options?: ValidatorOptions);
        options: ValidatorOptions;
        errors(): any;
        hideMessages(): void;
        validate(): boolean;
        validateInput(input: Element): boolean;
        validateInput(input: JQuery): boolean;
    }

    interface ValidatorOptions {
        name?: string;
        errorTemplate?: string;
        messages?: any;
        rules?: any;
        validateOnBlur?: boolean;
        validate?(e: ValidatorValidateEvent): void;
    }

    interface ValidatorEvent {
        sender: Validator;
        isDefaultPrevented(): boolean;
        preventDefault: Function;
    }

    interface ValidatorValidateEvent extends ValidatorEvent {
    }


}

interface HTMLElement {
    kendoBindingTarget: kendo.data.Binding;
}

interface JQueryXHR {
}

interface JQueryEventObject {
}

interface JQueryPromise<T> {
}

interface JQuery {

    kendoDraggable(): JQuery;
    kendoDraggable(options: kendo.ui.DraggableOptions): JQuery;

    kendoDropTarget(): JQuery;
    kendoDropTarget(options: kendo.ui.DropTargetOptions): JQuery;

    kendoDropTargetArea(): JQuery;
    kendoDropTargetArea(options: kendo.ui.DropTargetAreaOptions): JQuery;

    data(key: any): any;

    kendoMobileActionSheet(): JQuery;
    kendoMobileActionSheet(options: kendo.mobile.ui.ActionSheetOptions): JQuery;
    data(key: "kendoMobileActionSheet") : kendo.mobile.ui.ActionSheet;

    kendoMobileBackButton(): JQuery;
    kendoMobileBackButton(options: kendo.mobile.ui.BackButtonOptions): JQuery;
    data(key: "kendoMobileBackButton") : kendo.mobile.ui.BackButton;

    kendoMobileButton(): JQuery;
    kendoMobileButton(options: kendo.mobile.ui.ButtonOptions): JQuery;
    data(key: "kendoMobileButton") : kendo.mobile.ui.Button;

    kendoMobileButtonGroup(): JQuery;
    kendoMobileButtonGroup(options: kendo.mobile.ui.ButtonGroupOptions): JQuery;
    data(key: "kendoMobileButtonGroup") : kendo.mobile.ui.ButtonGroup;

    kendoMobileDetailButton(): JQuery;
    kendoMobileDetailButton(options: kendo.mobile.ui.DetailButtonOptions): JQuery;
    data(key: "kendoMobileDetailButton") : kendo.mobile.ui.DetailButton;

    kendoMobileDrawer(): JQuery;
    kendoMobileDrawer(options: kendo.mobile.ui.DrawerOptions): JQuery;
    data(key: "kendoMobileDrawer") : kendo.mobile.ui.Drawer;

    kendoMobileLayout(): JQuery;
    kendoMobileLayout(options: kendo.mobile.ui.LayoutOptions): JQuery;
    data(key: "kendoMobileLayout") : kendo.mobile.ui.Layout;

    kendoMobileListView(): JQuery;
    kendoMobileListView(options: kendo.mobile.ui.ListViewOptions): JQuery;
    data(key: "kendoMobileListView") : kendo.mobile.ui.ListView;

    kendoMobileLoader(): JQuery;
    kendoMobileLoader(options: kendo.mobile.ui.LoaderOptions): JQuery;
    data(key: "kendoMobileLoader") : kendo.mobile.ui.Loader;

    kendoMobileModalView(): JQuery;
    kendoMobileModalView(options: kendo.mobile.ui.ModalViewOptions): JQuery;
    data(key: "kendoMobileModalView") : kendo.mobile.ui.ModalView;

    kendoMobileNavBar(): JQuery;
    kendoMobileNavBar(options: kendo.mobile.ui.NavBarOptions): JQuery;
    data(key: "kendoMobileNavBar") : kendo.mobile.ui.NavBar;

    kendoMobilePane(): JQuery;
    kendoMobilePane(options: kendo.mobile.ui.PaneOptions): JQuery;
    data(key: "kendoMobilePane") : kendo.mobile.ui.Pane;

    kendoMobilePopOver(): JQuery;
    kendoMobilePopOver(options: kendo.mobile.ui.PopOverOptions): JQuery;
    data(key: "kendoMobilePopOver") : kendo.mobile.ui.PopOver;

    kendoMobileScrollView(): JQuery;
    kendoMobileScrollView(options: kendo.mobile.ui.ScrollViewOptions): JQuery;
    data(key: "kendoMobileScrollView") : kendo.mobile.ui.ScrollView;

    kendoMobileScroller(): JQuery;
    kendoMobileScroller(options: kendo.mobile.ui.ScrollerOptions): JQuery;
    data(key: "kendoMobileScroller") : kendo.mobile.ui.Scroller;

    kendoMobileSplitView(): JQuery;
    kendoMobileSplitView(options: kendo.mobile.ui.SplitViewOptions): JQuery;
    data(key: "kendoMobileSplitView") : kendo.mobile.ui.SplitView;

    kendoMobileSwitch(): JQuery;
    kendoMobileSwitch(options: kendo.mobile.ui.SwitchOptions): JQuery;
    data(key: "kendoMobileSwitch") : kendo.mobile.ui.Switch;

    kendoMobileTabStrip(): JQuery;
    kendoMobileTabStrip(options: kendo.mobile.ui.TabStripOptions): JQuery;
    data(key: "kendoMobileTabStrip") : kendo.mobile.ui.TabStrip;

    kendoMobileView(): JQuery;
    kendoMobileView(options: kendo.mobile.ui.ViewOptions): JQuery;
    data(key: "kendoMobileView") : kendo.mobile.ui.View;

    kendoTouch(): JQuery;
    kendoTouch(options: kendo.ui.TouchOptions): JQuery;
    data(key: "kendoTouch") : kendo.ui.Touch;

    kendoValidator(): JQuery;
    kendoValidator(options: kendo.ui.ValidatorOptions): JQuery;
    data(key: "kendoValidator") : kendo.ui.Validator;

}
