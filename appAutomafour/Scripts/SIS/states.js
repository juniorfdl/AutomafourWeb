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
        }).state('cad_apartamento', {
            url: '',
            templateUrl: 'features/CAD/cad_apartamento/edit.html',
            controller: 'CrudCad_ApartamentoCtrl',
            controllerAs: 'ctrl',
            resolve: {
                lista: function (CrudCad_ApartamentoService) {
                    return CrudCad_ApartamentoService.buscar('', 1, 'id', false, 15, '');
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
        }).state('cad_veiculo', {
            url: '',
            templateUrl: 'features/CAD/cad_veiculo/edit.html',
            controller: 'CrudCad_VeiculoCtrl',
            controllerAs: 'ctrl',
            resolve: {
                lista: function (CrudCad_VeiculoService) {
                    return CrudCad_VeiculoService.buscar('', 1, 'id', false, 15, '');
                }
            }
        }).state('mov_entrada', {
            url: '',
            templateUrl: 'features/MOV/mov_entrada/edit.html',
            controller: 'CrudMov_EntradaCtrl',
            controllerAs: 'ctrl',
            resolve: {
                lista: function (CrudMov_EntradaService) {
                    return [];//CrudMov_EntradaService.buscar('', 1, 'id', false, 15, '');
                }
            }

        }).state('cad_servico', {
            url: '',
            templateUrl: 'features/CAD/cad_servico/edit.html',
            controller: 'Crudcad_servicoCtrl',
            controllerAs: 'ctrl',
            resolve: {
                lista: function (Crudcad_servicoService) {
                    return Crudcad_servicoService.buscar('', 1, 'CODIGO_SERVICO', false, 15, '');
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
        }).state('cad_servico_imposto', {
            url: '',
            templateUrl: 'features/CAD/cad_servico_imposto/edit.html',
            controller: 'Crudcad_servico_impostoCtrl',
            controllerAs: 'ctrl',
            resolve: {
                lista: function (Crudcad_servico_impostoService) {
                    return Crudcad_servico_impostoService.buscar('', 1, 'NOME_CIDADE', true, 15, '');
                }
            }
        }).state('cad_banco', {
            url: '',
            templateUrl: 'features/CAD/cad_banco/edit.html',
            controller: 'Crudcad_bancoCtrl',
            controllerAs: 'ctrl',
            resolve: {
                lista: function (Crudcad_bancoService) {
                    return Crudcad_bancoService.buscar('', 1, 'CODIGO', true, 15, '');
                }
            }
        }).state('fat_nf_servico', {
            url: '',
            templateUrl: 'features/FAT/fat_nf_servico/edit.html',
            controller: 'Crudfat_nf_servicoCtrl',
            controllerAs: 'ctrl',
            resolve: {
                lista: function (Crudfat_nf_servicoService) {
                    return Crudfat_nf_servicoService.buscar('', 1, 'DATA_EMISSAO', false, 15, '');
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