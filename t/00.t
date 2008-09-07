use Test::Simple 'no_plan';
use strict;
use lib './lib';
use Sys::Filesystem::ID ':all';


my $tmp = './t/testfile';
`touch $tmp`;


my $absid = abs_id($tmp);
ok($absid,"abs id suggested for $tmp; $absid");


my $id = get_id($tmp);

if ( $id ){
   print STDERR " - id exists : $id, $absid\n";

}
else { 

   my $idc = create_id($tmp);
   ok $idc, "id created $idc";


   my $get = get_id($tmp);

   ok $get, "id gottent $get";

   unlink $absid;

}


for ( 1 .. 4 ){
   my $nid = Sys::Filesystem::ID::_generate_new_id();
   ok $nid, "new id sample: $nid";
}







ok 1,"overriding the id gen... ";

sub Sys::Filesystem::ID::_generate_new_id {
   
   my $id = $ENV{HOSTNAME} or warn('no ENV HOSTNAME');
   $id .= '.'.(int rand 20000);

   return $id;
}


for ( 1 .. 4 ){
   my $nid = Sys::Filesystem::ID::_generate_new_id();
   ok $nid, "new id sample: $nid";
}





unlink $tmp;






