var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var App;
(function (App) {
    var Controllers;
    (function (Controllers) {
        'use strict';
        var CrudCad_PessoaCtrl = (function (_super) {

            __extends(CrudCad_PessoaCtrl, _super);
            function CrudCad_PessoaCtrl($rootScope, api, CrudCad_PessoaService, lista, $q, $scope, $filter) {
                var _this = this;
                _super.call(this);

                this.$rootScope = $rootScope;
                this.api = api;
                this.crudSvc = CrudCad_PessoaService;
                this.lista = lista;
            }

            CrudCad_PessoaCtrl.prototype.crud = function () {
                return "Cad_Pessoa";
            };

            CrudCad_PessoaCtrl.prototype.prepararParaSalvar = function () {
            };

            CrudCad_PessoaCtrl.prototype.execAposNovo = function () {
                this.currentRecord.ATIVO = "S";
                this.currentRecord.TIPO = "C";
            };

            return CrudCad_PessoaCtrl;
        })(Controllers.CrudBaseEditCtrl);
        Controllers.CrudCad_PessoaCtrl = CrudCad_PessoaCtrl;

        App.modules.Controllers.controller('CrudCad_PessoaCtrl', CrudCad_PessoaCtrl);

    })(Controllers = App.Controllers || (App.Controllers = {}));
})(App || (App = {}));
//# sourceMappingURL=ctrl.js.map