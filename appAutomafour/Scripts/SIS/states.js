var App;
(function (App) {
    'use strict';

    App.modules.App.config(function ($stateProvider) {

        $stateProvider.state('home', {
            url: '/home',
            templateUrl: 'views/index.html'
        }).state('login', {
            url: '/login',
            layout: 'basic',
            templateUrl: 'views/login.html',
            controller: 'LoginCtrl',
            controllerAs: 'ctrl',
            data: {
                title: "Entrar"
            }
        }).state('usuario', {
            url: '',
            templateUrl: 'features/SIS/Sis_Usuario/edit.html',
            controller: 'CrudSis_UsuarioCtrl',
            controllerAs: 'ctrl',
            resolve: {
                lista: function (CrudSis_UsuarioService) {
                    return CrudSis_UsuarioService.buscar('', 1, 'NOME', false, 15, '');
                }
            }        
        }).state('cad_pessoa', {
            url: '',
            templateUrl: 'features/CAD/Cad_Pessoa/edit.html',
            controller: 'CrudCad_PessoaCtrl',
            controllerAs: 'ctrl',
            resolve: {
                lista: function (CrudCad_PessoaService) {
                    return CrudCad_PessoaService.buscar('', 1, 'NOME', false, 15, '');
                }
            }
        }).state('cad_pessoaversao', {
            url: '',
            templateUrl: 'features/CAD/v_Cad_PessoaVersao/edit.html',
            controller: 'Crudv_Cad_PessoaVersaoCtrl',
            controllerAs: 'ctrl',
            resolve: {
                lista: function (Crudv_Cad_PessoaVersaoService) {
                    return Crudv_Cad_PessoaVersaoService.buscar('', 1, 'CLIENTE', false, 15, '');
                }
            }
        }).state('cad_empresa', {
            url: '',
            templateUrl: 'features/CAD/cad_empresa/edit.html',
            controller: 'CrudCad_EmpresaCtrl',
            controllerAs: 'ctrl',
            resolve: {
                lista: function (CrudCad_EmpresaService) {
                    return CrudCad_EmpresaService.buscar('', 1, 'NOME', false, 15, '');
                }
            }
        }).state('sis_menu', {
            url: '',
            templateUrl: 'features/SIS/sis_menu/edit.html',
            controller: 'Crudsis_menuCtrl',
            controllerAs: 'ctrl',
            resolve: {
                lista: function (Crudsis_menuService) {
                    return Crudsis_menuService.buscar('', 1, 'GRUPO', true, 15, '');
                }
            }
        }).state("otherwise",
          {
              url: '/home',
              templateUrl: 'views/index.html'
          }
        );

    });

})(App || (App = {}));
//# sourceMappingURL=app.js.map