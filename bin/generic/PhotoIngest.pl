#!/usr/bin/perl -w

use strict;
use Gtk2 -init;
use Glib qw(TRUE FALSE);
use warnings;
use diagnostics;
use File::Find;

my $storage       = '/home/arwagner/Photo/Darkroom';
my $sdcard        = '/media/arwagner/NIKON D90';
my $foldername    = '';

my $maxfoldersize = 8096; # maximum size of target in MB

my $ARGC = @ARGV;
if ($ARGC == 2) {
	$sdcard  = $ARGV[0];
	$storage = $ARGV[1];
}
# for (my $i=0; $i < $ARGC; $i++) {
# 	print "$i => $ARGV[$i]\n";
# }
# die;

my $window = Gtk2::Window->new ('toplevel');
$window->signal_connect (delete_event => sub { 
		system("/bin/umount '$sdcard'");
		Gtk2->main_quit; });
$window->set_default_icon_from_file('/usr/share/icons/gnome/256x256/devices/media-flash.png');
$window->set_default_icon_from_file('/home/arwagner/.icons/arwagner/devices/sd.png');


my $Input= &ret_Input($sdcard, $storage, $foldername);
$window->add($Input);

#----------------------------------------------------------------------
sub Ingest($$$) {
	my ($src, $dst, $folder) = @_;
  	print("Initiating ingest...\n");

	# Copy files to storage using exiftool. The dateformat sets up a
	# directory structure like (ie. basedir/<month><2-digit-year>)
	#      storage/0112/<folder>/
	# and names the files like (ie. R<year><month><day>-<filenumber>.<extension>)
	#      R20120101-1234.NEF
	# The trick here is to set a funny "dateformat", that contains some
	# subfolder information
	my $ingester      = '/usr/bin/exiftool';
	my $ingestparam   = '-o . -r ';
	my $filename      = '\'-FileName<' . $dst. '/${CreateDate}-${filenumber}.%e\'';
	my $dateformat    = '-d %m%y/' . $folder . '/R%Y%m%d';
	if ($dst =~ m/Darkroom/) {
		# if we're ingesting to a generic "darkroom" we just rename the
		# images but do not create subfolder structures.
		$dateformat    = '-d /R%Y%m%d';
	} 

	print "$src -> $dst \n";

	print ("/bin/sh $ingester $ingestparam $filename $dateformat '$src'\n");
	system("/bin/sh $ingester $ingestparam $filename $dateformat '$src'");
}

#----------------------------------------------------------------------
sub show_chooser {
	my($heading,$type,$filter) =@_;
	#$type can be:
	#* 'open' 
	#* 'save' 
	#* 'select-folder'
	#* 'create-folder' 
	my $file_chooser =  Gtk2::FileChooserDialog->new ( 
						$heading,
						undef,
						$type,
						'gtk-cancel' => 'cancel',
						'gtk-ok' => 'ok'
					);
	(defined $filter)&&($file_chooser->add_filter($filter));
	#if action = 'save' suggest a filename
	($type eq 'save')&&($file_chooser->set_current_name("suggeste_this_file.name"));

	my $filename;
	if ('ok' eq $file_chooser->run){		
		$filename = $file_chooser->get_filename;
	}
	$file_chooser->destroy;
	if (defined $filename){
		 if ((-f $filename)&&($type eq 'save')) {
			  my $overwrite =show_message_dialog( $window,
										'question',
										'Overwrite existing file:'."<b>\n$filename</b>",
										'yes-no'
							);
				return  if ($overwrite eq 'no');
		 }
		return $filename;
	}
	return;
}


#----------------------------------------------------------------------
sub ret_Input($$$) {

	my ($src, $dst, $folder) = @_;

	my $vbox = Gtk2::VBox->new(FALSE,4);

	my $table = Gtk2::Table->new (4, 4, FALSE);

	my $iconsize = 'dialog';

	my $btn_select_src = Gtk2::Button->new($src);
	my $lbl_src = Gtk2::Label->new_with_mnemonic('Source folder: ');
	my $src_status = Gtk2::Image->new_from_stock('gtk-save', $iconsize);
	my $src_folder_size = 0;
	my $lbl_src_size = Gtk2::Label->new('');
	$sdcard = $src;
	my $filecount = -1;
	find( sub {
			$filecount++;
			$src_folder_size += -s;
		}, $sdcard
	);
	$src_folder_size = $src_folder_size / 1024 / 1024;
	my $msg = sprintf("%5i files", $filecount) . " : " . sprintf("%5.0f MB ", $src_folder_size);
	$lbl_src_size->set_text($msg);

 	$lbl_src->set_alignment (1, 0.5);
	$btn_select_src->signal_connect(
		'clicked' => sub{ 
			my $oldsrc = $src;
			$src = show_chooser('Select source folder','select-folder');
			if (defined($src)) {
				$btn_select_src->set_label($src);
				$sdcard = $src;

				$src_folder_size = 0;
				my $filecount = -1;
				find( sub {
						$filecount++;
						$src_folder_size += -s;
					}, $sdcard
				);
				$src_folder_size = $src_folder_size / 1024 / 1024;
				my $msg = sprintf("%5i files", $filecount) . " : " . sprintf("%5.0f MB ", $src_folder_size);
				$lbl_src_size->set_text($msg);
				print "$msg\n";
			}
			else {
				$src = $sdcard;
			}
		}
	);
  	$table->attach_defaults ($lbl_src, 0, 1, 0, 1);
	$table->attach_defaults ($btn_select_src, 1, 2, 0, 1);
	$table->attach_defaults ($src_status, 2, 3, 0, 1);
	$table->attach_defaults ($lbl_src_size, 3, 4, 0, 1);

	my $btn_select_dst = Gtk2::Button->new($dst);
	my $lbl_dst = Gtk2::Label->new_with_mnemonic('Destination folder: ');
	my $dst_folder_size = 0;
	my $dst_status = Gtk2::Image->new_from_stock('gtk-harddisk', $iconsize);
	my $lbl_dst_size = Gtk2::Label->new('');
	$storage = $dst;
	
	$filecount = -1;
	find( sub {
			$dst_folder_size += -s;
		}, $storage
	);
	$dst_folder_size = $dst_folder_size / 1024 / 1024;
	$msg = sprintf("%5i files", $filecount) . " : " . sprintf("%5.0f MB ", $dst_folder_size);

	$lbl_dst_size->set_text($msg);
 	$lbl_dst->set_alignment (1, 0.5);
	$btn_select_dst->signal_connect(
		'clicked' => sub{ 
			my $olddst = $dst;
			$dst = show_chooser('Select source folder','select-folder');
			if (defined($dst)) {
				$btn_select_dst->set_label($dst);
				$storage = $dst;

				$dst_folder_size = 0;
				my $filecount = -1;
				find( sub {
						$filecount++;
						$dst_folder_size += -s;
					}, $storage
				);
				$dst_folder_size = $dst_folder_size / 1024 / 1024;
				my $msg = sprintf("%5i files", $filecount) . " : " . sprintf("%5.0f MB ", $dst_folder_size);
				$lbl_dst_size->set_text($msg);

				my $space = $maxfoldersize - $dst_folder_size - $src_folder_size;
				if ($space < 0) {
					$dst_status->set_from_stock('gtk-stop', $iconsize)
				} else {
					$dst_status->set_from_stock('gtk-save-as', $iconsize)
				}

				# TODO evaluate this sensibly
				print "$space MB left\n";
			}
			else {
				$dst = $storage;
			}
		}
	);
  	$table->attach_defaults ($lbl_dst, 0, 1, 1, 2);
	$table->attach_defaults ($btn_select_dst, 1, 2, 1, 2);
	$table->attach_defaults ($dst_status, 2, 3, 1, 2);
  	$table->attach_defaults ($lbl_dst_size, 3, 4, 1, 2);


	my $lbl_folder = Gtk2::Label->new_with_mnemonic('Folder: ');
 	$lbl_folder->set_alignment (1, 0.5);
	my $folder_status = Gtk2::Image->new_from_stock('gtk-folder-new', $iconsize);
	my $ent_folder = Gtk2::Entry->new();
	$lbl_folder->set_mnemonic_widget ($ent_folder);
	$table->attach_defaults ($lbl_folder, 0, 1, 2, 3);
	$table->attach_defaults ($ent_folder, 1, 2, 2, 3);
	$table->attach_defaults ($folder_status, 2, 3, 2, 3);


	$vbox->pack_end($table,FALSE,FALSE,1);

	# my $button = Gtk2::Button->new ('Ingest');
	my $button = Gtk2::Button->new();
	## $button->set_image(Gtk2::Image->new_from_stock('gtk-stop', $iconsize));
	## $button->set_image_position('GTK_POS_LEFT');
	$button->set_label("Ingest");
	$button->signal_connect (clicked => sub {
		$folder = $ent_folder->get_text();
		Ingest($src, $dst, $folder)
	});
	$vbox->pack_end($button, FALSE, FALSE, 2);
	
	$vbox->show_all();

	return $vbox;
}

#======================================================================

$window->show_all;
Gtk2->main;
