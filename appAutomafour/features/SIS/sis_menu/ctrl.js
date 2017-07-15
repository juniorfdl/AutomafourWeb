
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
        var Crudsis_menuCtrl = (function (_super) {

            __extends(Crudsis_menuCtrl, _super);
            function Crudsis_menuCtrl($rootScope, api, Crudsis_menuService, lista, $q, $scope) {
                var _this = this;
                _super.call(this);

                this.$rootScope = $rootScope;

                this.api = api;
                this.crudSvc = Crudsis_menuService;
                this.lista = lista;

            }

            Crudsis_menuCtrl.prototype.crud = function () {
                return "sis_menu";
            };

            return Crudsis_menuCtrl;
        })(Controllers.CrudBaseEditCtrl);
        Controllers.Crudsis_menuCtrl = Crudsis_menuCtrl;

        App.modules.Controllers.controller('Crudsis_menuCtrl', Crudsis_menuCtrl);


    })(Controllers = App.Controllers || (App.Controllers = {}));
})(App || (App = {}));
//# sourceMappingURL=ctrl.js.map