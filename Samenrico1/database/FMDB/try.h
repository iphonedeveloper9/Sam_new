//
//  try.h
//  MadMayan
//
//  Created by SAJID ALI on 10/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface try : NSObject {

}
/*
 
 AppDelegate_iPhone *delegate = (AppDelegate_iPhone*)[[UIApplication sharedApplication] delegate];
 FMDatabase *db = delegate.calDB;
 
 [db beginTransaction];
 //hint [db executeUpdate:@"insert into TABLENAME (FIELD1,FIELD2,FILED3) values(?,?,?);" , 
 [dict objectforkey:@"bookid"],
  [dict objectforkey:@"bookid2"],
  [dict objectforkey:@"bookid3"]];
 [db commit];
 
 /*
@end
/*
AppDelegate_iPhone *delegate = (AppDelegate_iPhone*)[[UIApplication sharedApplication] delegate];
FMDatabase *db = delegate.calDB;

[db beginTransaction];
//hint [db executeUpdate:@"insert into TABLENAME (FIELD1,FIELD2,FILED3) values(?,?,?);" , 
 [dict objectforkey:@"bookid"],
 [
 [db executeUpdate:@"insert into book (unit,pid,roomname,prilength,priwidth,priheight,priarea,prifirstcoat,prifirstarea,prifirstpaint,prisecondcoat,prisecondarea,prisecondpaint,pritexture,cewidth,ceheight,cearea,cefirstcoat,cefirstarea,cefirstpaint,cesecondcoat,cesecondarea,cesecondpaint,cetexture,fewidth,feheight,fearea,fefirstcoat,fefirstarea,fefirstpaint, fesecondcoat, fesecondarea,fesecondpaint,trwidth,trheight,trarea,trpaint,subarea,d32,d36,d48,d6,d8,doh,dow,doa,ws,wm,wl,woh,wow,woa,notpainted) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);" ,
 unit,
 pid,
 [txtRoomName text],
 [txtRoomLength text],
 [txtRoomWidth text],
 [txtRoomHeight text],
 
 
 [lblRoomArea text],
 [btnFeFirstCoat.titleLabel text],
 [lblPriFirstArea text],
 [lblPriFirstPaint text],
 [btnPriSecondCoat.titleLabel text],
 [lblPriSecondArea text],
 [lblPriSecondPaint text],
 [btnPriTexture.titleLabel text],
 
 [txtCeilingWidth text],
 [txtCeilingHeight text],
 [lblCeillingArea text],
 [btnCeFirstCoat.titleLabel text],
 [lblCeFirstArea text],
 [lblCeFirstPaint text],
 [btnCeSecondCoat.titleLabel text],
 [lblCeSecondArea text],
 [lblceSecondPaint text],
 [btnCeTexture.titleLabel text],
 
 [txtFeatureWidth text],
 [txtFeatureHeight text],
 [lblFeatureArea text],
 [btnFeFirstCoat.titleLabel text],
 [lblFeFirstArea text],
 [lblFeFirstPaint text],
 [btnFeSecondCoat.titleLabel text],
 [lblFeSecondArea text],
 [lblFeSecondPaint text],
 
 [txtTrimWidth text],
 [txtTrimHeight text],
 [lblTrimArea text],
 [lblTrimPaint text],
 [lblSubTotal text],
 
 [txtDoor32 text],
 [txtDoor36 text],
 [txtDoor48 text],
 [txtDoor6 text],
 [txtDoor8 text],
 [txtdoorOtherHeight text],
 [txtdoorOtherWidth text],
 [lblDOtherArea text],
 [txtWindowSmall text],
 [txtWindowMedium text],
 [txtWindowLarge text],
 [txtWindowOtherHeight text],
 [txtWindowOtherWidth text],
 [lblWOtherArea text],
 [lblAreNotPainted text]];
[db commit];
UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"The record save successfully"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
[alert show];
[alert release];
*/

///////////
//getdate
/*
  NSMutableArray data;
 
 
 data=nil;
    data=[[NSMutableArray alloc] init];
    
    paintCalculatorAppDelegate *delegate = (paintCalculatorAppDelegate*)[[UIApplication sharedApplication] delegate];
    FMDatabase *db = delegate.calDB;
    
    FMResultSet *result = [db executeQuery:@"SELECT bookid FROM book"];
    
    while ([result next]) {

        [data addObject:[result stringForColumn:@"bookid"]];
        [anOBJ release];
 */
