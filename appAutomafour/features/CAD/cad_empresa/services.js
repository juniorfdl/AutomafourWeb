

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
        var CrudCad_EmpresaService = (function (_super) {
            __extends(CrudCad_EmpresaService, _super);

            function CrudCad_EmpresaService($q, api, $rootScope) {
                _super.apply(this, arguments);                
            }

            Object.defineProperty(CrudCad_EmpresaService.prototype, "baseEntity", {
                /// @override
                get: function () {
                    return 'CAD_EMPRESA';
                },
                enumerable: true,
                configurable: true
            });            
   
            return CrudCad_EmpresaService;
        })(Services.CrudBaseService);
        Services.CrudCad_EmpresaService = CrudCad_EmpresaService;
        App.modules.Services
            .service('CrudCad_EmpresaService', CrudCad_EmpresaService);
    })(Services = App.Services || (App.Services = {}));
})(App || (App = {}));
//# sourceMappingURL=services.js.map