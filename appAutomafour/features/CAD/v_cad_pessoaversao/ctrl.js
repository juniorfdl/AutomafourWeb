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
        var Crudv_Cad_PessoaVersaoCtrl = (function (_super) {

            __extends(Crudv_Cad_PessoaVersaoCtrl, _super);
            function Crudv_Cad_PessoaVersaoCtrl($rootScope, api, Crudv_Cad_PessoaVersaoService, lista, $q, $scope, $filter) {
                var _this = this;
                _super.call(this);

                this.$rootScope = $rootScope;
                this.api = api;
                this.crudSvc = Crudv_Cad_PessoaVersaoService;
                this.lista = lista;              
            }

            Crudv_Cad_PessoaVersaoCtrl.prototype.crud = function () {
                return "v_Cad_PessoaVersao";
            };

            Crudv_Cad_PessoaVersaoCtrl.prototype.prepararParaSalvar = function () {
                this.mainForm.$setDirty();
                this.mainForm.$pristine = false;
            };

            return Crudv_Cad_PessoaVersaoCtrl;
        })(Controllers.CrudBaseEditCtrl);
        Controllers.Crudv_Cad_PessoaVersaoCtrl = Crudv_Cad_PessoaVersaoCtrl;

        App.modules.Controllers.controller('Crudv_Cad_PessoaVersaoCtrl', Crudv_Cad_PessoaVersaoCtrl);

    })(Controllers = App.Controllers || (App.Controllers = {}));
})(App || (App = {}));
//# sourceMappingURL=ctrl.js.map