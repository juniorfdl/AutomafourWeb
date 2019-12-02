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
        var Crudv_Cad_PessoaVersaoService = (function (_super) {
            __extends(Crudv_Cad_PessoaVersaoService, _super);

            function Crudv_Cad_PessoaVersaoService($q, api, $rootScope) {
                _super.apply(this, arguments);
            }

            Object.defineProperty(Crudv_Cad_PessoaVersaoService.prototype, "baseEntity", {
                /// @override
                get: function () {
                    return 'v_Cad_PessoaVersao';
                },
                enumerable: true,
                configurable: true
            });

            return Crudv_Cad_PessoaVersaoService;
        })(Services.CrudBaseService);
        Services.Crudv_Cad_PessoaVersaoService = Crudv_Cad_PessoaVersaoService;
        App.modules.Services
            .service('Crudv_Cad_PessoaVersaoService', Crudv_Cad_PessoaVersaoService);
    })(Services = App.Services || (App.Services = {}));
})(App || (App = {}));
//# sourceMappingURL=services.js.map