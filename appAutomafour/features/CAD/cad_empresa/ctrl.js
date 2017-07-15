
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
        var CrudCad_EmpresaCtrl = (function (_super) {

            __extends(CrudCad_EmpresaCtrl, _super);
            function CrudCad_EmpresaCtrl($rootScope, api, CrudCad_EmpresaService, lista, $q, $scope, $filter) {
                var _this = this;
                _super.call(this);
                              
                this.$rootScope = $rootScope;
                this.api = api;
                this.crudSvc = CrudCad_EmpresaService;
                this.lista = lista; 
            }

            CrudCad_EmpresaCtrl.prototype.crud = function () {
                return "Cad_Empresa";
            };

            CrudCad_EmpresaCtrl.prototype.prepararParaSalvar = function () {
                this.currentRecord.NOME = this.currentRecord.NOME.toUpperCase();
                this.currentRecord.CEMP = this.currentRecord.CEMP.toUpperCase();
                this.currentRecord.FANTASIA = this.currentRecord.FANTASIA.toUpperCase();
            };

            return CrudCad_EmpresaCtrl;
        })(Controllers.CrudBaseEditCtrl);
        Controllers.CrudCad_EmpresaCtrl = CrudCad_EmpresaCtrl;     

        App.modules.Controllers.controller('CrudCad_EmpresaCtrl', CrudCad_EmpresaCtrl);

    })(Controllers = App.Controllers || (App.Controllers = {}));
})(App || (App = {}));
//# sourceMappingURL=ctrl.js.map