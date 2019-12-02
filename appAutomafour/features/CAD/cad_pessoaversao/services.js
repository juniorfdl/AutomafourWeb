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
        var CrudCad_PessoaVersaoService = (function (_super) {
            __extends(CrudCad_PessoaVersaoService, _super);

            function CrudCad_PessoaVersaoService($q, api, $rootScope) {
                _super.apply(this, arguments);
            }

            Object.defineProperty(CrudCad_PessoaVersaoService.prototype, "baseEntity", {
                /// @override
                get: function () {
                    return 'Cad_PessoaVersao';
                },
                enumerable: true,
                configurable: true
            });

            return CrudCad_PessoaVersaoService;
        })(Services.CrudBaseService);
        Services.CrudCad_PessoaVersaoService = CrudCad_PessoaVersaoService;
        App.modules.Services
            .service('CrudCad_PessoaVersaoService', CrudCad_PessoaVersaoService);
    })(Services = App.Services || (App.Services = {}));
})(App || (App = {}));
//# sourceMappingURL=services.js.map