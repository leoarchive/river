with builtins;

{
  createUser = name: old: toFile ./users.txt "name: ${name} old ${toString old}";
}