<?php
require_once './dao/UsuarioDao.php';
require_once './dao/PersonaDao.php';
require_once './models/Usuario.php';
require_once './models/Persona.php';
require_once './helpers/response.php';
require_once './dao/UserRoleDao.php';

class UsuarioController
{
    private $dao;
    private $personaDao;
    private $userRoleDao;

    public function __construct()
    {
        $this->dao = new UsuarioDao();
        $this->personaDao = new PersonaDao();
        $this->userRoleDao = new UserRoleDAO();
    }

    public function index()
    {
        $stmt = $this->dao->getAll();
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($data as &$usr) {
            $usr['roles'] = $this->userRoleDao->getRolesByUser($usr['id']);
            $usr['persona'] = $this->personaDao->getById($usr['persona_id']);
        }
        echo jsonResponse($data);
    }

    public function show($id)
    {
        $stmt = $this->dao->getById($id);
        $data = $stmt->fetch(PDO::FETCH_ASSOC);
        $statusCode = 200;
        $statusText = 'Ok';
        if (empty($data)) {
            $statusCode = 404;
            $statusText = 'Not found';
        }
        echo jsonResponse($data, $statusCode, $statusText);
    }

    public function store()
    {
        $data = json_decode(file_get_contents("php://input"), true);
        $obj = new Usuario();
        $persona = new Persona();
        foreach ($data as $key => $value) {
            if ($key == 'nombre' || $key == 'apellido') {
                $persona->$key = $value;
            }
            if (property_exists($obj, $key)) {
                $obj->$key = $value;
            }
        }
        $result_persona = $this->personaDao->insert($persona);
        $obj->persona_id = $result_persona;
        $idUsuario = $this->dao->insert($obj);
        $result = $this->userRoleDao->assignRole($idUsuario, '2');
        echo jsonResponse(['success' => $result], 201, 'Created');
    }

    public function update($id)
    {
        $data = json_decode(file_get_contents("php://input"), true);
        $obj = new Usuario();
        $obj->id = $id;
        foreach ($data as $key => $value) {
            if (property_exists($obj, $key)) {
                $obj->$key = $value;
            }
        }
        $result = $this->dao->update($obj);
        echo jsonResponse(['success' => $result]);
    }

    public function destroy($id)
    {
        $result = $this->dao->delete($id);
        echo jsonResponse(['success' => $result]);
    }
}
?>