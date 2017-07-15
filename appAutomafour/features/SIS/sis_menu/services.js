

var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};

var App;
(function (App) {
    var Services;
    (function (Services) {
        "use strict";
        var Crudsis_menuService = (function (_super) {
            __extends(Crudsis_menuService, _super);

            function Crudsis_menuService($q, api, $rootScope) {
                _super.apply(this, arguments);
            }

            Object.defineProperty(Crudsis_menuService.prototype, "baseEntity", {
                /// @override
                get: function () {
                    return 'sis_menu';
                },
                enumerable: true,
                configurable: true
            });            
   
            return Crudsis_menuService;
        })(Services.CrudBaseService);
        Services.Crudsis_menuService = Crudsis_menuService;
        App.modules.Services
            .service('Crudsis_menuService', Crudsis_menuService);
    })(Services = App.Services || (App.Services = {}));
})(App || (App = {}));
//# sourceMappingURL=services.js.map