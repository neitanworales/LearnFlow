import { Component, OnInit } from '@angular/core';
import { UsuarioDao } from 'src/app/core/dao/UsuarioDao';
import { Usuario } from 'src/app/core/model/Usuario';

@Component({
  selector: 'app-usuarios',
  templateUrl: './usuarios.component.html',
  styleUrls: ['./usuarios.component.scss']
})
export class UsuariosComponent implements OnInit {

  data: Usuario[] = new Array();

  columnsToDisplay = [
    'id',
    'persona_id',
    'email',
    'contrasena',
    'rol_id',
    'fecha_registro'
  ];

  constructor(
    private usuarioDao: UsuarioDao
  ) { }

  ngOnInit(): void {
    this.cargarDatos();
  }

  cargarDatos() {
    this.usuarioDao.getUsuarios().subscribe(
      result => {
        this.data = result.data!;
      }
    );
  }

}
