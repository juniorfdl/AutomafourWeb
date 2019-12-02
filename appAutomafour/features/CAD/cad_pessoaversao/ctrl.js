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
        var CrudCad_PessoaVersaoCtrl = (function (_super) {

            __extends(CrudCad_PessoaVersaoCtrl, _super);
            function CrudCad_PessoaVersaoCtrl($rootScope, api, CrudCad_PessoaVersaoService, lista, $q, $scope, $filter) {
                var _this = this;
                _super.call(this);

                this.$rootScope = $rootScope;
                this.api = api;
                this.crudSvc = CrudCad_PessoaVersaoService;
                this.lista = lista;

                this.Add30Dias = function () {
                    var CurrentDate = new Date();
                    CurrentDate.setMonth(CurrentDate.getMonth() + 2);                    
                    this.currentRecord.DATA_AUTORIZACAO = CurrentDate;
                    this.mainForm.$setDirty();
                };                
            }

            CrudCad_PessoaVersaoCtrl.prototype.crud = function () {
                return "Cad_PessoaVersao";
            };

            CrudCad_PessoaVersaoCtrl.prototype.prepararParaSalvar = function () {
                this.mainForm.$setDirty();
                this.mainForm.$pristine = false;
            };

            CrudCad_PessoaVersaoCtrl.prototype.execAposNovo = function () {
                this.currentRecord.ATIVO = "S";
                this.currentRecord.TIPO = "C";
            };

            return CrudCad_PessoaVersaoCtrl;
        })(Controllers.CrudBaseEditCtrl);
        Controllers.CrudCad_PessoaVersaoCtrl = CrudCad_PessoaVersaoCtrl;

        App.modules.Controllers.controller('CrudCad_PessoaVersaoCtrl', CrudCad_PessoaVersaoCtrl);

    })(Controllers = App.Controllers || (App.Controllers = {}));
})(App || (App = {}));
//# sourceMappingURL=ctrl.js.map