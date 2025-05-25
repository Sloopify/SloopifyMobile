import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/utils/helper/snackbar.dart';
import 'dart:typed_data';

import 'package:sloopify_mobile/features/create_posts/domain/entities/custom_album.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../data/models/album_model.dart';

class CreateAlbumScreen extends StatefulWidget {
  final bool toCreateAlbum;
  final Function() ?updateAfterCreateAlbum;

  const CreateAlbumScreen({super.key,this.toCreateAlbum=true, this.updateAfterCreateAlbum});
  @override
  State<CreateAlbumScreen> createState() => _CreateAlbumScreenState();
}

class _CreateAlbumScreenState extends State<CreateAlbumScreen> {
  final List<AssetEntity> _media = [];
  final List<AssetEntity> _selected = [];
  final ScrollController _scrollController = ScrollController();

  int _currentPage = 0;
  bool _isLoading = false;
  final int _pageSize = 60;
  Map<String, Uint8List> _thumbnailCache = {};
  @override
  void initState() {
    super.initState();
    _requestAndLoad();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        _loadMoreMedia();
      }
    });
  }

  Future<void> _requestAndLoad() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (permission.isAuth) {
      _loadMoreMedia();
    } else {
      await PhotoManager.openSetting();
    }
  }

  Future<void> _loadMoreMedia() async {
    if (_isLoading) return;
    _isLoading = true;

    final albums = await PhotoManager.getAssetPathList(type: RequestType.common);
    if (albums.isEmpty) return;

    final recent = albums.first;
    final newAssets = await recent.getAssetListPaged(page: _currentPage, size: _pageSize);

    if (newAssets.isNotEmpty) {
      setState(() {
        _media.addAll(newAssets);
        _currentPage++;
      });
    }

    _isLoading = false;
  }

  void _toggleSelection(AssetEntity asset) {
    _selected.contains(asset) ? _selected.remove(asset) : _selected.add(asset);

    setState(() {
    });
  }
  Future<void> createNewAlbum( List<AssetEntity> selectedAssets,final Function() updateListOfAlbum) async {
    final box = Hive.box<AlbumModel>('albums');
    final assetIds = selectedAssets.map((a) => a.id).toList();

    final album = AlbumModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      assetIds: assetIds,
    );

    await box.add(album);
    showSnackBar(context, "Album created  ${album.id}");

    Navigator.pop(context);
    updateListOfAlbum();
  }

  void _createAlbum() async {
    final name = "Album ${DateTime.now().millisecondsSinceEpoch}";
    final id = UniqueKey().toString();

    final album = CustomAlbum(
      assets: _selected,
      id: id,
      name: name,
      assetIds: _selected.map((e) => e.id).toList(),
    );

    final box = await Hive.openBox('albums');
    await box.put(id, album.toMap());

    showSnackBar(context, "Album created  ${album.name}");

    Navigator.pop(context); // or go to albums list
  }

  Widget _buildGridItem(AssetEntity asset) {
    return StatefulBuilder(
      builder: (context, setLocalState) {
        final isSelected = _selected.contains(asset);
        final assetId = asset.id;

        return GestureDetector(
          onTap: () async {
            if(widget.toCreateAlbum){
              setState(() {
                isSelected ? _selected.remove(asset) : _selected.add(asset);
              });
              setLocalState(() {});
            }else{
              context.read<CreatePostCubit>().setImages((await asset.file)!);
            }

          },
          child: Stack(
            children: [
              Positioned.fill(
                child: _thumbnailCache.containsKey(assetId)
                    ? Image.memory(_thumbnailCache[assetId]!, fit: BoxFit.cover)
                    : FutureBuilder<Uint8List?>(
                  future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                      _thumbnailCache[assetId] = snapshot.data!;
                      return Image.memory(snapshot.data!, fit: BoxFit.cover);
                    }
                    return Container(color: Colors.grey[300]);
                  },
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(Icons.check_circle, color: Colors.green, size: 24),
                ),
              if(asset.type==AssetType.video)
                Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.play_arrow,color: ColorManager.black,),
                )
            ],
          ),
        );
      },
    );
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context,title: "New album"),
      body: Stack(
        children: [
          GridView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            padding: EdgeInsets.all(4),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: _media.length,
            itemBuilder: (_, index) => _buildGridItem(_media[index]),
          ),
          if (_selected.isNotEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 60,
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p50,
                  vertical: AppPadding.p8,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                      blurRadius: 6,
                      color: ColorManager.black.withOpacity(0.25),
                    ),
                  ],
                ),
                child: CustomElevatedButton(
                  label:widget.toCreateAlbum?"create your album (${_selected.length})":"Done",
                  onPressed:widget.toCreateAlbum? ()=>createNewAlbum(_selected..map((e)=>e.id).toList(),widget.updateAfterCreateAlbum!):(){

                  },
                  backgroundColor: ColorManager.primaryColor,
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}